load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'

@test "checking that config files are in place" {
  run docker exec dnsmasq bash -c "ls /etc/dnsmasq.d/ | wc -l"
  assert_success
  assert_output 5
}
