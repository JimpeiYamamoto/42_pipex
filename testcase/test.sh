chmod 000 ./testcase/no_open_infile
chmod 000 ./testcase/no_open_outfile
echo "==========================================================="
echo "standard input"
echo "==========================================================="
./pipex ./testcase/empty_infile "ls -a" "wc -l" ./testcase/outfile_my
< ./testcase/empty_infile ls -a | wc -l > ./testcase/outfile_ans
go run ./testcase/check.go no_infile "ls -a | wc -l"

./pipex ./testcase/empty_infile "ls -a" "grep my" ./testcase/outfile_my
< ./testcase/empty_infile ls -a | grep my > ./testcase/outfile_ans
go run ./testcase/check.go no_infile "ls -a | grep my"

./pipex ./testcase/empty_infile "ls -a" "grep z" ./testcase/outfile_my
< ./testcase/empty_infile ls -a | grep z > ./testcase/outfile_ans
go run ./testcase/check.go no_infile "ls -a | grep z"

./pipex ./testcase/empty_infile "cat -e" "wc -l" ./testcase/outfile_my
< ./testcase/empty_infile cat -e | wc -l > ./testcase/outfile_ans
go run ./testcase/check.go empty_infile "cat -e | wc -l"

./pipex ./testcase/simple_infile "cat -e -n" "cat -e" ./testcase/outfile_my
< ./testcase/simple_infile cat -e -n | cat -e > ./testcase/outfile_ans
go run ./testcase/check.go simple_infile "cat -e -n | cat -e"

./pipex ./testcase/simple2_infile "cat -e -n" "cat -e" ./testcase/outfile_my
< ./testcase/simple2_infile cat -e -n | cat -e > ./testcase/outfile_ans
go run ./testcase/check.go simple_infile2 "cat -e -n | cat -e"

./pipex ./testcase/simple2_infile "cat -e -n" "cat -e" ./testcase/outfile_my
< ./testcase/simple2_infile cat -e -n | cat -e > ./testcase/outfile_ans
go run ./testcase/check.go simple_infile2 "cat -e -n | cat -e"

./pipex ./testcase/normal_infile "cat -e -n" "cat -e" ./testcase/outfile_my
< ./testcase/normal_infile cat -e -n | cat -e > ./testcase/outfile_ans
go run ./testcase/check.go normal_infile "cat -e -n | cat -e"

./pipex ./testcase/normal_infile "cat -e -n" "xargs" ./testcase/outfile_my
< ./testcase/normal_infile cat -e -n | xargs > ./testcase/outfile_ans
go run ./testcase/check.go normal_infile "cat -e -n | xargs"

./pipex ./testcase/big_infile "cat -e -n" "xargs" ./testcase/outfile_my
< ./testcase/big_infile cat -e -n | xargs > ./testcase/outfile_ans
go run ./testcase/check.go big_infile "cat -e -n | xargs"

echo "==========================================================="
echo "Absolute path input"
echo "==========================================================="
./pipex ./testcase/empty_infile "/bin/ls -a" "/bin/wc -l" ./testcase/outfile_my
< ./testcase/empty_infile /bin/ls -a | /bin/wc -l > ./testcase/outfile_ans
go run ./testcase/check.go no_infile "/bin/ls -a | /bin/wc -l"

./pipex ./testcase/empty_infile "/bin/ls -a" "/bin/grep my" ./testcase/outfile_my
< ./testcase/empty_infile /bin/ls -a | /bin/grep my > ./testcase/outfile_ans
go run ./testcase/check.go no_infile "/bin/ls -a | /bin/grep my"

./pipex ./testcase/empty_infile "/bin/ls -a" "/bin/grep z" ./testcase/outfile_my
< ./testcase/empty_infile /bin/ls -a | /bin/grep z > ./testcase/outfile_ans
go run ./testcase/check.go no_infile "/bin/ls -a | /bin/grep z"

./pipex ./testcase/empty_infile "/bin/cat -e" "/bin/wc -l" ./testcase/outfile_my
< ./testcase/empty_infile /bin/cat -e | /bin/wc -l > ./testcase/outfile_ans
go run ./testcase/check.go empty_infile "/bin/cat -e | /bin/wc -l"

./pipex ./testcase/simple_infile "/bin/cat -e -n" "/bin/cat -e" ./testcase/outfile_my
< ./testcase/simple_infile /bin/cat -e -n | /bin/cat -e > ./testcase/outfile_ans
go run ./testcase/check.go simple_infile "/bin/cat -e -n | /bin/cat -e"

./pipex ./testcase/simple2_infile "/bin/cat -e -n" "/bin/cat -e" ./testcase/outfile_my
< ./testcase/simple2_infile /bin/cat -e -n | /bin/cat -e > ./testcase/outfile_ans
go run ./testcase/check.go simple_infile2 "/bin/cat -e -n | /bin/cat -e"

./pipex ./testcase/simple2_infile "/bin/cat -e -n" "/bin/cat -e" ./testcase/outfile_my
< ./testcase/simple2_infile /bin/cat -e -n | /bin/cat -e > ./testcase/outfile_ans
go run ./testcase/check.go simple_infile2 "/bin/cat -e -n | /bin/cat -e"

./pipex ./testcase/normal_infile "/bin/cat -e -n" "/bin/cat -e" ./testcase/outfile_my
< ./testcase/normal_infile /bin/cat -e -n | /bin/cat -e > ./testcase/outfile_ans
go run ./testcase/check.go normal_infile "/bin/cat -e -n | /bin/cat -e"

./pipex ./testcase/normal_infile "/bin/cat -e -n" "/bin/xargs" ./testcase/outfile_my
< ./testcase/normal_infile /bin/cat -e -n | /bin/xargs > ./testcase/outfile_ans
go run ./testcase/check.go normal_infile "/bin/cat -e -n | /bin/xargs"

./pipex ./testcase/big_infile "/bin/cat -e -n" "/bin/xargs" ./testcase/outfile_my
< ./testcase/big_infile /bin/cat -e -n | /bin/xargs > ./testcase/outfile_ans
go run ./testcase/check.go big_infile "/bin/cat -e -n | /bin/xargs"

echo "==========================================================="
echo "Error Handling"
echo "==========================================================="
echo "=====1====="
echo "=my_output="
./pipex ./testcase/big_infile "cat -n"  "cat -e" ./testcase/no_open_outfile
echo "=ans_output="
< ./testcase/big_infile cat -n | cat -e > ./testcase/no_open_outfile
echo "=====2====="
echo "=my_output="
./pipex ./testcase/big_infile "cat -n"  "hoge2" ./testcase/outfile_my
echo "=ans_output="
< ./testcase/big_infile cat -n | hoge2 > ./testcase/outfile_ans
echo "=====3====="
echo "=my_output="
./pipex ./testcase/big_infile "cat -n"  "hoge2" ./testcase/no_open_outfile
echo "=ans_output="
< ./testcase/big_infile cat -n | hoge2 > ./testcase/no_open_outfile
echo "=====4====="
echo "=my_output="
./pipex ./testcase/big_infile "hoge1"  "cat -e" ./testcase/outfile
echo "=ans_output="
< ./testcase/big_infile hoge1 | cat -e > ./testcase/outfile
echo "=====5====="
echo "=my_output="
./pipex ./testcase/big_infile "hoge1"  "cat -e" ./testcase/no_open_outfile
echo "=ans_output="
< ./testcase/big_infile hoge1 | cat -e > ./testcase/no_open_outfile
echo "=====6====="
echo "=my_output="
./pipex ./testcase/big_infile "hoge1"  "hoge2" ./testcase/outfile_my
echo "=ans_output="
< ./testcase/big_infile hoge1 | hoge2 > ./testcase/outfile_ans
echo "=====7====="
echo "=my_output="
./pipex ./testcase/big_infile "hoge1"  "hoge2" ./testcase/no_open_outfile
echo "=ans_output="
< ./testcase/big_infile hoge1 | hoge2 > ./testcase/no_open_outfile
echo "=====8====="
echo "=my_output="
./pipex ./testcase/no_open_infile "cat -n"  "cat -e" ./testcase/outfile_my
echo "=ans_output="
< ./testcase/no_open_infile cat -n | cat -e > ./testcase/outfile_ans
echo "=====9====="
echo "=my_output="
./pipex ./testcase/no_open_infile "cat -n"  "cat -e" ./testcase/no_open_outfile
echo "=ans_output="
< ./testcase/no_open_infile cat -n | cat -e > ./testcase/no_open_outfile
echo "====10====="
echo "=my_output="
./pipex ./testcase/no_open_infile "cat -n"  "hoge2" ./testcase/outfile_my
echo "=ans_output="
< ./testcase/no_open_infile cat -n | hoge2 > ./testcase/outfile_ans
echo "====11====="
echo "=my_output="
./pipex ./testcase/no_open_infile "cat -n"  "hoge2" ./testcase/no_open_outfile
echo "=ans_output="
< ./testcase/no_open_infile cat -n | hoge2 > ./testcase/no_open_outfile
echo "====12====="
echo "=my_output="
./pipex ./testcase/no_open_infile "hoge1"  "cat -e" ./testcase/outfile_my
echo "=ans_output="
< ./testcase/no_open_infile hoge1 | cat -e > ./testcase/outfile_ans
echo "====13====="
echo "=my_output="
./pipex ./testcase/no_open_infile "hoge1"  "cat -e" ./testcase/no_open_outfile
echo "=ans_output="
< ./testcase/no_open_infile hoge1 | cat -e > ./testcase/no_open_outfile
echo "====14====="
echo "=my_output="
./pipex ./testcase/no_open_infile "hoge1"  "hoge2" ./testcase/outfile_my
echo "=ans_output="
< ./testcase/no_open_infile hoge1 | hoge2 > ./testcase/outfile_ans
echo "====15====="
echo "=my_output="
./pipex ./testcase/no_open_infile "hoge1"  "hoge2" ./testcase/no_open_outfile
echo "=ans_output="
< ./testcase/no_open_infile hoge1 | hoge2 > ./testcase/no_open_outfile
echo "==========================================================="
echo "Unset PATH"
echo "==========================================================="
unset PATH
echo "==========================================================="
echo "standard input"
echo "==========================================================="
./pipex ./testcase/empty_infile "ls -a" "wc -l" ./testcase/outfile_my
< ./testcase/empty_infile ls -a | wc -l > ./testcase/outfile_ans
go run ./testcase/check.go no_infile "ls -a | wc -l"

./pipex ./testcase/empty_infile "ls -a" "grep my" ./testcase/outfile_my
< ./testcase/empty_infile ls -a | grep my > ./testcase/outfile_ans
go run ./testcase/check.go no_infile "ls -a | grep my"

./pipex ./testcase/empty_infile "ls -a" "grep z" ./testcase/outfile_my
< ./testcase/empty_infile ls -a | grep z > ./testcase/outfile_ans
go run ./testcase/check.go no_infile "ls -a | grep z"

./pipex ./testcase/empty_infile "cat -e" "wc -l" ./testcase/outfile_my
< ./testcase/empty_infile cat -e | wc -l > ./testcase/outfile_ans
go run ./testcase/check.go empty_infile "cat -e | wc -l"

./pipex ./testcase/simple_infile "cat -e -n" "cat -e" ./testcase/outfile_my
< ./testcase/simple_infile cat -e -n | cat -e > ./testcase/outfile_ans
go run ./testcase/check.go simple_infile "cat -e -n | cat -e"

./pipex ./testcase/simple2_infile "cat -e -n" "cat -e" ./testcase/outfile_my
< ./testcase/simple2_infile cat -e -n | cat -e > ./testcase/outfile_ans
go run ./testcase/check.go simple_infile2 "cat -e -n | cat -e"

./pipex ./testcase/simple2_infile "cat -e -n" "cat -e" ./testcase/outfile_my
< ./testcase/simple2_infile cat -e -n | cat -e > ./testcase/outfile_ans
go run ./testcase/check.go simple_infile2 "cat -e -n | cat -e"

./pipex ./testcase/normal_infile "cat -e -n" "cat -e" ./testcase/outfile_my
< ./testcase/normal_infile cat -e -n | cat -e > ./testcase/outfile_ans
go run ./testcase/check.go normal_infile "cat -e -n | cat -e"

./pipex ./testcase/normal_infile "cat -e -n" "xargs" ./testcase/outfile_my
< ./testcase/normal_infile cat -e -n | xargs > ./testcase/outfile_ans
go run ./testcase/check.go normal_infile "cat -e -n | xargs"

./pipex ./testcase/big_infile "cat -e -n" "xargs" ./testcase/outfile_my
< ./testcase/big_infile cat -e -n | xargs > ./testcase/outfile_ans
go run ./testcase/check.go big_infile "cat -e -n | xargs"

echo "==========================================================="
echo "Absolute path input"
echo "==========================================================="
./pipex ./testcase/empty_infile "/bin/ls -a" "/bin/wc -l" ./testcase/outfile_my
< ./testcase/empty_infile /bin/ls -a | /bin/wc -l > ./testcase/outfile_ans
go run ./testcase/check.go no_infile "/bin/ls -a | /bin/wc -l"

./pipex ./testcase/empty_infile "/bin/ls -a" "/bin/grep my" ./testcase/outfile_my
< ./testcase/empty_infile /bin/ls -a | /bin/grep my > ./testcase/outfile_ans
go run ./testcase/check.go no_infile "/bin/ls -a | /bin/grep my"

./pipex ./testcase/empty_infile "/bin/ls -a" "/bin/grep z" ./testcase/outfile_my
< ./testcase/empty_infile /bin/ls -a | /bin/grep z > ./testcase/outfile_ans
go run ./testcase/check.go no_infile "/bin/ls -a | /bin/grep z"

./pipex ./testcase/empty_infile "/bin/cat -e" "/bin/wc -l" ./testcase/outfile_my
< ./testcase/empty_infile /bin/cat -e | /bin/wc -l > ./testcase/outfile_ans
go run ./testcase/check.go empty_infile "/bin/cat -e | /bin/wc -l"

./pipex ./testcase/simple_infile "/bin/cat -e -n" "/bin/cat -e" ./testcase/outfile_my
< ./testcase/simple_infile /bin/cat -e -n | /bin/cat -e > ./testcase/outfile_ans
go run ./testcase/check.go simple_infile "/bin/cat -e -n | /bin/cat -e"

./pipex ./testcase/simple2_infile "/bin/cat -e -n" "/bin/cat -e" ./testcase/outfile_my
< ./testcase/simple2_infile /bin/cat -e -n | /bin/cat -e > ./testcase/outfile_ans
go run ./testcase/check.go simple_infile2 "/bin/cat -e -n | /bin/cat -e"

./pipex ./testcase/simple2_infile "/bin/cat -e -n" "/bin/cat -e" ./testcase/outfile_my
< ./testcase/simple2_infile /bin/cat -e -n | /bin/cat -e > ./testcase/outfile_ans
go run ./testcase/check.go simple_infile2 "/bin/cat -e -n | /bin/cat -e"

./pipex ./testcase/normal_infile "/bin/cat -e -n" "/bin/cat -e" ./testcase/outfile_my
< ./testcase/normal_infile /bin/cat -e -n | /bin/cat -e > ./testcase/outfile_ans
go run ./testcase/check.go normal_infile "/bin/cat -e -n | /bin/cat -e"

./pipex ./testcase/normal_infile "/bin/cat -e -n" "/bin/xargs" ./testcase/outfile_my
< ./testcase/normal_infile /bin/cat -e -n | /bin/xargs > ./testcase/outfile_ans
go run ./testcase/check.go normal_infile "/bin/cat -e -n | /bin/xargs"

./pipex ./testcase/big_infile "/bin/cat -e -n" "/bin/xargs" ./testcase/outfile_my
< ./testcase/big_infile /bin/cat -e -n | /bin/xargs > ./testcase/outfile_ans
go run ./testcase/check.go big_infile "/bin/cat -e -n | /bin/xargs"
echo "==========================================================="
echo "Error Handling"
echo "==========================================================="

echo "=====1====="
echo "=my_output="
./pipex ./testcase/big_infile "cat -n"  "cat -e" ./testcase/no_open_outfile
echo "=ans_output="
< ./testcase/big_infile cat -n | cat -e > ./testcase/no_open_outfile
echo "=====2====="
echo "=my_output="
./pipex ./testcase/big_infile "cat -n"  "hoge2" ./testcase/outfile_my
echo "=ans_output="
< ./testcase/big_infile cat -n | hoge2 > ./testcase/outfile_ans
echo "=====3====="
echo "=my_output="
./pipex ./testcase/big_infile "cat -n"  "hoge2" ./testcase/no_open_outfile
echo "=ans_output="
< ./testcase/big_infile cat -n | hoge2 > ./testcase/no_open_outfile
echo "=====4====="
echo "=my_output="
./pipex ./testcase/big_infile "hoge1"  "cat -e" ./testcase/outfile
echo "=ans_output="
< ./testcase/big_infile hoge1 | cat -e > ./testcase/outfile
echo "=====5====="
echo "=my_output="
./pipex ./testcase/big_infile "hoge1"  "cat -e" ./testcase/no_open_outfile
echo "=ans_output="
< ./testcase/big_infile hoge1 | cat -e > ./testcase/no_open_outfile
echo "=====6====="
echo "=my_output="
./pipex ./testcase/big_infile "hoge1"  "hoge2" ./testcase/outfile_my
echo "=ans_output="
< ./testcase/big_infile hoge1 | hoge2 > ./testcase/outfile_ans
echo "=====7====="
echo "=my_output="
./pipex ./testcase/big_infile "hoge1"  "hoge2" ./testcase/no_open_outfile
echo "=ans_output="
< ./testcase/big_infile hoge1 | hoge2 > ./testcase/no_open_outfile
echo "=====8====="
echo "=my_output="
./pipex ./testcase/no_open_infile "cat -n"  "cat -e" ./testcase/outfile_my
echo "=ans_output="
< ./testcase/no_open_infile cat -n | cat -e > ./testcase/outfile_ans
echo "=====9====="
echo "=my_output="
./pipex ./testcase/no_open_infile "cat -n"  "cat -e" ./testcase/no_open_outfile
echo "=ans_output="
< ./testcase/no_open_infile cat -n | cat -e > ./testcase/no_open_outfile
echo "====10====="
echo "=my_output="
./pipex ./testcase/no_open_infile "cat -n"  "hoge2" ./testcase/outfile_my
echo "=ans_output="
< ./testcase/no_open_infile cat -n | hoge2 > ./testcase/outfile_ans
echo "====11====="
echo "=my_output="
./pipex ./testcase/no_open_infile "cat -n"  "hoge2" ./testcase/no_open_outfile
echo "=ans_output="
< ./testcase/no_open_infile cat -n | hoge2 > ./testcase/no_open_outfile
echo "====12====="
echo "=my_output="
./pipex ./testcase/no_open_infile "hoge1"  "cat -e" ./testcase/outfile_my
echo "=ans_output="
< ./testcase/no_open_infile hoge1 | cat -e > ./testcase/outfile_ans
echo "====13====="
echo "=my_output="
./pipex ./testcase/no_open_infile "hoge1"  "cat -e" ./testcase/no_open_outfile
echo "=ans_output="
< ./testcase/no_open_infile hoge1 | cat -e > ./testcase/no_open_outfile
echo "====14====="
echo "=my_output="
./pipex ./testcase/no_open_infile "hoge1"  "hoge2" ./testcase/outfile_my
echo "=ans_output="
< ./testcase/no_open_infile hoge1 | hoge2 > ./testcase/outfile_ans
echo "====15====="
echo "=my_output="
./pipex ./testcase/no_open_infile "hoge1"  "hoge2" ./testcase/no_open_outfile
echo "=ans_output="
< ./testcase/no_open_infile hoge1 | hoge2 > ./testcase/no_open_outfile


/bin/echo "==========================================================="
/bin/chmod 777 ./testcase/no_open_infile
/bin/chmod 777 ./testcase/no_open_outfile
