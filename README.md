# act_score_sampler

An attempt to understand how different proportions of ACT scores impact the total class average

## Original question (paraphrased from Akil Bello)

Given the fact that schools only report ACT scores to IPEDs in various bins,
to what degree could an institution drop the lowest score bins while still
maintaining or even increasing the average score or IQR?

### Method

To answer this question, I attempted to create an analytic data set using a two step process:

1. Programmatically create a data set with every possible combination of probabilities across the six buckets which summed to a total of 1. For example this set `{.01,.01,.01,.01,.01,.01}` would get rejected from the final data set because it only accounts for a total of 6% whereas this set `{.95,.01,.01.,01,.01,.01}` would be persist in the data since it sums to 1 (or 100%). Since each item in the vector represents a different ACT range, `{.01,.01,.01.,01,.01,.95}` would also satisfy the requirements.  

Unfortunately, every probability ranging from .01 - .99 was simply too large a search space given existing time, memory, and compute. Therefore, I shrunk the search space to enable the highest ACT score bucket (30-36) to vary between .70 and .99 and the bottom five buckets to vary between .01 and .30. The assumption was that selective schools would seek to maximize the top bin at the expense of the others. This assumption might not be correct.

Even with those limitations, the search space yielded 729 million total combinations of which approximately 128,000 summed to one.

2. Programmatically sample theoretical "incoming classes" and generating summary statistics for each of the acceptable combinations. This is the final analytic file which can be visualized, modeled, or summarized for greater clarity on the question

The process here included drawing 50 appropriately sampled classes of 1,500 "students" each using the various probability combinations. These classes were then summarized to create mean, median, 25th and 75th percentile and sd statistics. 

### Theory vs. Brute Force

Admittedly (and clearly) I am not a trained statistician. Therefore, I am intrigued by whether there is a theoretical/conceptual proof that would deliver similar results without resorting to a brute force optimization. Ideas or feedback on this front are welcome. File an issue or feel free to Tweet me `@brad_weiner`.

### The Data Files

All data in this repo is synthetically produced and can therefore be shared. 

The contents:

`/data/raw/akil_combinations.csv` <--- All of the possible combinations in the search space

`/data/transformed/first_row_df.csv` <--- A dummy file that is the stub for creating the full descriptives

`/data/transformed/run_file_pre_join.csv` <--- The summary statistics before joining on with the ids and the probabilities

`/data/transformed/run_file_post_join.csv` <--- The summary statistics after joining on with the ids and the probabilities

`/data/final_analytic_files/final_file_for_akil.csv` <--- Final analytic file with better named columns and removed useless columns  

### Results and Viz

This is only the data. Please send your results and viz my way. Very curious what anyone out there finds, discovers or learns from this synthetic data set.

### License

Shield: [![CC BY 4.0][cc-by-shield]][cc-by]

This work is licensed under a
[Creative Commons Attribution 4.0 International License][cc-by].

[![CC BY 4.0][cc-by-image]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg

### Code of Conduct

Please see the [code of conduct](https://github.com/bradweiner/act_score_sampler/blob/main/CODE_OF_CONDUCT.md) in this repo.

















