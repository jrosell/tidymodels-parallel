# run-tidymodels-parallel.sh

unset R_HOME
echo "" > tidymodels-parallel.out
echo "" > tidymodels-parallel-tmp.out

R CMD BATCH '--args n_rsamples=3 n_observations=10000 n_grid=2' tidymodels-parallel.R tidymodels-parallel-tmp.out
cat tidymodels-parallel-tmp.out >> tidymodels-parallel.out

R CMD BATCH '--args n_rsamples=4 n_observations=10000 n_grid=2' tidymodels-parallel.R tidymodels-parallel-tmp.out
cat tidymodels-parallel-tmp.out >> tidymodels-parallel.out

R CMD BATCH '--args n_rsamples=5 n_observations=10000 n_grid=2' tidymodels-parallel.R tidymodels-parallel-tmp.out
cat tidymodels-parallel-tmp.out >> tidymodels-parallel.out

R CMD BATCH '--args n_rsamples=6 n_observations=10000 n_grid=2' tidymodels-parallel.R tidymodels-parallel-tmp.out
cat tidymodels-parallel-tmp.out >> tidymodels-parallel.out

R CMD BATCH '--args n_rsamples=7 n_observations=10000 n_grid=2' tidymodels-parallel.R tidymodels-parallel-tmp.out
cat tidymodels-parallel-tmp.out >> tidymodels-parallel.out

R CMD BATCH '--args n_rsamples=8 n_observations=10000 n_grid=2' tidymodels-parallel.R tidymodels-parallel-tmp.out
cat tidymodels-parallel-tmp.out >> tidymodels-parallel.out

R CMD BATCH '--args n_rsamples=9 n_observations=10000 n_grid=2' tidymodels-parallel.R tidymodels-parallel-tmp.out
cat tidymodels-parallel-tmp.out >> tidymodels-parallel.out

R CMD BATCH '--args n_rsamples=10 n_observations=10000 n_grid=2' tidymodels-parallel.R tidymodels-parallel-tmp.out
cat tidymodels-parallel-tmp.out >> tidymodels-parallel.out

R CMD BATCH '--args n_rsamples=3 n_observations=10000 n_grid=10' tidymodels-parallel.R tidymodels-parallel-tmp.out
cat tidymodels-parallel-tmp.out >> tidymodels-parallel.out

R CMD BATCH '--args n_rsamples=4 n_observations=10000 n_grid=10' tidymodels-parallel.R tidymodels-parallel-tmp.out
cat tidymodels-parallel-tmp.out >> tidymodels-parallel.out

R CMD BATCH '--args n_rsamples=5 n_observations=10000 n_grid=10' tidymodels-parallel.R tidymodels-parallel-tmp.out
cat tidymodels-parallel-tmp.out >> tidymodels-parallel.out

R CMD BATCH '--args n_rsamples=6 n_observations=10000 n_grid=10' tidymodels-parallel.R tidymodels-parallel-tmp.out
cat tidymodels-parallel-tmp.out >> tidymodels-parallel.out

R CMD BATCH '--args n_rsamples=7 n_observations=10000 n_grid=10' tidymodels-parallel.R tidymodels-parallel-tmp.out
cat tidymodels-parallel-tmp.out >> tidymodels-parallel.out

R CMD BATCH '--args n_rsamples=8 n_observations=10000 n_grid=10' tidymodels-parallel.R tidymodels-parallel-tmp.out
cat tidymodels-parallel-tmp.out >> tidymodels-parallel.out

R CMD BATCH '--args n_rsamples=9 n_observations=10000 n_grid=10' tidymodels-parallel.R tidymodels-parallel-tmp.out
cat tidymodels-parallel-tmp.out >> tidymodels-parallel.out

R CMD BATCH '--args n_rsamples=10 n_observations=10000 n_grid=10' tidymodels-parallel.R tidymodels-parallel-tmp.out
cat tidymodels-parallel-tmp.out >> tidymodels-parallel.out

rm tidymodels-parallel-tmp.out