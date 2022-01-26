package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"os"
)

func main() {
	f_my, err := os.Open("testcase/outfile_my")
	if err != nil {
		fmt.Println("can't open outfile_my")
	}
	f_ans, err := os.Open("testcase/outfile_ans")
	if err != nil {
		fmt.Println("can't open outfile_ans")
	}
	defer f_my.Close()
	defer f_ans.Close()
	b_my, err := ioutil.ReadAll(f_my)
	if err != nil {
		fmt.Println("can't read outfile_my")
	}
	b_ans, err := ioutil.ReadAll(f_ans)
	if err != nil {
		fmt.Println("can't read outfile_ans")
	}
	my_string := string(b_my)
	ans_string := string(b_ans)
	flag.Parse()
	fmt.Printf("[%v] : %v\n", flag.Args()[0], flag.Args()[1])
	if my_string == ans_string {
		fmt.Println("*OK*")
	} else {
		fmt.Println("*KO*")
		//fmt.Printf("ans_output:%v", ans_string)
		//fmt.Printf("my__output:%v", my_string)
	}
}
