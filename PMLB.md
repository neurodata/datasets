# [Penn Machine Learning Benchmarks](https://github.com/EpistasisLab/penn-ml-benchmarks)

## Instructions for Use

### R

Begin by cloning the repository:

```
git clone https://github.com/EpistasisLab/penn-ml-benchmarks.git
```

Next, source the following script from this repository:

```
source(<path/to/neurodata/datasets/repo>/PMLB/load_pmlb.R)
```

Finally use the following script to load the desired data:

```
result <- load.pmlb('<dataset-name>', "<path/to/EpistasisLab/penn-ml-benchmarks/repo>", '<task-type>')
```

where `<dataset-name>` is the name of the dataset as it appears in the PMLB repo, and `<task-type>` is either `"classification"` or `"regression"` according to the directory it appears in the PMLB repo.
