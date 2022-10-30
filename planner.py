import json
import itertools
import yaml
import time
import os
import subprocess
from yaml.loader import SafeLoader

REPO = "repoArchive"
ENVN = "envName"
OUTD = "outputDirectory"
HYPS = "hyperparams"
SPPA = "specificParams"

'''
Get the configuration from the file
'''
def read_and_parse_config(config_path):
    with open(config_path, 'r') as config_file:
        config = json.load(config_file)
    
    return config


'''
Get iterable search grid from the config
'''
def get_iterable_search_grid(config):
    hyps = config[HYPS]
    param_lists = [[(k, v) for k, v in hyps[param_name]] for param_name in hyps.keys()]

    return [dict(param_set) for param_set in itertools.product(*param_lists)]


'''
Merge new configs into old configs
'''
def merge_configs(old_configs, new_configs):
    delta = []
    for key, value in new_configs:
        if key in old_configs:
            delta.append((key, old_configs[key], value))
            old_configs[key] = value
        else:
            print(f"WARN: Config {key}:{value} missing in old, skipping")
    
    print ("Changes:")
    for delt in delta:
        print(delt)
    
    return old_configs
        

'''
Pass params to yaml file
'''
def replace_params(run_config_path, param_dict):
    with open(run_config_path, 'r') as run_config_file:
        run_config = yaml.load(run_config_file, Loader=SafeLoader)
    
    run_config = merge_configs(run_config, param_dict)

    with open(run_config_path, 'w') as write_config_file:
        yaml.dump(run_config, write_config_file)
    
    print (f"Done writing new configurations: {run_config} to {run_config_path}")


def set_up_repo_for_config(source_file, output_base):
    epoch_now = int(time.time())
    output_path = f"{output_base}/{epoch_now}"
    os.makedirs(output_path)
    subprocess.run(["unzip", source_file, "-d", output_path], shell=True, check=True)
    print (f"Created working directory at {output_path}")

    return output_path


def generate_slurm_submit_script(repo_base_path):
    with open("templates/slurm-submit-template.sh", 'r') as template_file:
        content = template_file.read()
    
    identifying_ts = repo_base_path.split('/')[-1]
    content.replace("$$JOB_NAME$$", f"HYP_{identifying_ts}_run")
    content.replace("$$PARTITION_TYPE$$", f"long")
    content.replace("$$REPO_PATH$$", repo_base_path)

    with open(f"generated/slurm-submit-{identifying_ts}.sh", 'w') as generated_script:
        generated_script.write(content)
    
    print (f"Done generating slurm submit script for {repo_base_path}")

###############################################################################
# Main
###############################################################################

MAX_GRID_SIZE = 30
CONFIG_PATH = "./config-planner.json"

planner_config = read_and_parse_config(CONFIG_PATH)
search_grid = get_iterable_search_grid(planner_config)

print (f"Search grid size: {len(search_grid)}")

if len(search_grid) > 30:
    print (f"ERROR: Grid size {len(search_grid)} exceeded max grid size: {MAX_GRID_SIZE}")
    exit(1)

for i, param_set in enumerate(search_grid):
    print (f"Setting up repo for run config: {i}/{len(search_grid)}")

    # Set up repo for that param set
    repo_path = set_up_repo_for_config(planner_config['repoArchive'], planner_config['outputDirectory'])

    # Config path
    run_config_path = f"{repo_path}/SMARTS/competition/track1/train/config.yaml"

    # Update the configurations there
    replace_params(run_config_path, param_set)

    # Create the slurm submit scripts
    generate_slurm_submit_script(repo_path)

print ("Done. Set up completed for hyper parameter search grid")










    
