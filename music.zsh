typeset -A TAGS

function guess_tags(){
    local sample=$1
    TAGS[-g]=$(metaflac --show-tag GENRE $sample | awk -F= '{print $2}')
    TAGS[-d]=$(metaflac --show-tag DATE $sample | awk -F= '{print $2}')
    TAGS[-p]=$(metaflac --show-tag ARTIST $sample | awk -F= '{print $2}')
    TAGS[-t]=$(metaflac --show-tag ALBUM $sample | awk -F= '{print $2}')
    echo ${(kv)TAGS}
}

function print_cuesheet(){
    zparseopts -D -E -A TAGS g: d: p: t: s:
    local files=(${@})
    [[ ! -z $TAGS[-s] ]] && guess_tags $TAGS[-s]
    [[ ! -z $TAGS[-g] ]] && printf 'REM GENRE %s\n' $TAGS[-g]
    [[ ! -z $TAGS[-d] ]] && printf 'REM DATE %04d\n' $TAGS[-d]
    [[ ! -z $TAGS[-p] ]] && printf 'PERFORMER "%s"\n' $TAGS[-p]
    [[ ! -z $TAGS[-t] ]] && printf 'TITLE "%s"\n' $TAGS[-t]
    n=1
    for file in $files; do
        printf 'FILE "%s" WAVE\n  TRACK %02d AUDIO\n    TITLE "%s"\n    INDEX 01 00:00:00\n' $file $n ${file[4,-1]:r}
        ((++n))
    done
}

unset TAGS

function make_folder(){

    if (( $# != 1 )); then
        echo "Usage: image.png"
        return 1
    else
        local input=$1
        local output=Folder.jpg
        [[ ! -f $input ]] && echo "'$input' is not a file!" && return 1
        [[ -f $output ]] && echo "'$output' already exists!" && return 1
        convert -quality 100 -resize 198x198 -bordercolor black -border 1 $input $output
        [[ -f $output ]] && echo "'$output' generated from '$input'." && return 0
    fi

}
