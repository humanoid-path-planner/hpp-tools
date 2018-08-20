#!/usr/bin/awk -f
function deactivateThisTrace()
{
  parse = 0
  print_trace = 0
}
function deactivateThisFrame()
{
  print_frame = 0
}
BEGIN {
  parse = 0
  }
$0 ~ "=== end backtrace ==="{
  parse = 0
  if (print_trace == 1) {
    print trace
  }
}
$0 ~ "check_that_malloc_is_allowed|unit_test|in Eigen::" {
  deactivateThisFrame()
}
$0 ~ "Eigen::JacobiSVD" {
  deactivateThisTrace()
}
$0 ~ "hpp::pinocchio::|HierarchicalIterativeSolver::update" {
  deactivateThisTrace()
}
{
  if (parse == 1 && print_frame == 1) {
    trace = trace"\n"$0
  }
  print_frame = 1
}
$0 ~ "=== start backtrace ===" {
  trace = ""
  print_trace = 1
  parse = 1
}
END {}
