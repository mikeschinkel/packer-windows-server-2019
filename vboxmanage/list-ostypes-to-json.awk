#!/usr/bin/awk -f
# Parses `VBoxManage list ostypes`
BEGIN {
    FS = ":"
    printf "[\n"
}
{
    if (NR==1) {
        printf "\t{"
    } else {
        if (NR%6==1) {
            printf ",\n\t{"
        }
    }
    if (NR%6==0) {
        printf "}"
    } else {
        gsub(/ /, "_", $1)
        sub(/^[ \t]*/, "", $2)
        sub(/[ \t]*$/, "", $2)
        if ($2=="true" || $2=="false" ) {
            printf "\"%s\":%s", $1, $2
        }else {
            printf "\"%s\":\"%s\"", $1, $2
        }
        if (NR%6!=5) {
            printf ","
        }
    }

}
END {
    printf "\n]"
}