_hg_ps1() {
  hg prompt " {[hg]({branch})}{ at {bookmark}{status}" 2> /dev/null
}
