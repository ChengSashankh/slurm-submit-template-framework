# Project repository

## Example use

- Write this configuration:

```json
{
    "repoArchive": "/path/to/repo.zip",
    "envName": "py38new",
    "outputDirectory": "~/curr/runs",
    "hyperparams": {
        "train_steps": [10000, 50000, 100000],
        "epochs": [50, 75, 125],
        "batch_size": [128, 64, 32, 16],
        "clipping_limit": [0.2, 0.3, 0.4],
        "lambda": [],
        "kl_target": [0.01, 0.05, 0.25],
        "lr": [0.001, 0.01, 0.1],
        "action_freq": [],
        "checkpoint_freq": [20000],
        "img_meters": [50, 40, 30, 10],
        "img_pixels": [112, 56, 32],
        "num_stack": [3, 4, 5, 6],
        "scenarios": [
            ["1_to_2lane_left_turn_c", "1_to_2lane_left_turn_t", "3lane_merge_single_agent", "3lane_cruise_single_agent", "3lane_overtake"],
            ["1_to_2lane_left_turn_c"]
        ],
        "eval_eps": [50, 100, 200],
        "eval_freq": [50000]
    },
    "specificParams": []
}
```

- Generates a slurm submit script! Ha!

## Experimentation Framework

planner-config.json
planner.py
generated/worker-slurm-submit.sh
generated/params/param-{idx}.json

