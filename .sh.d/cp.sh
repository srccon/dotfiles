cpv() {
        rsync -pogbr -hhh --backup-dir=/tmp/rsync -e /dev/null --progress "$@"
}
