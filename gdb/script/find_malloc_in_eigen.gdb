break Eigen::internal::check_that_malloc_is_allowed
commands
echo === start backtrace ===\n
where
echo === end backtrace ===\n
cont
end
set logging file eigen_malloc_backtrace.txt
set logging redirect on
set logging on
set pagination off
set non-stop on
run
