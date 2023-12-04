package generator

import (
	"strings"
	"unicode"

	"github.com/serenize/snaker"
)

// Ucwords Ucwords
func Ucwords(str string) string {
	for i, v := range str {
		return string(unicode.ToUpper(v)) + str[i+1:]
	}
	return ""
}
func Lower(str string) string {
	return strings.ToLower(str)
}

func Inc(i int, step ...int) int {
	var add int = 1
	if len(step) > 0 {
		add = step[0]
	}
	return i + add

}

func ToPath(str string) string {
	temp := snaker.CamelToSnake(str)
	return strings.Join(strings.Split(temp, "_"), "/")
}

func In(s, sub string) bool {
	return strings.Contains(s, sub)
}
