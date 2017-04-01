# Add check for vim files
if [[ ! -d $VIMDIR/files ]];then 
    mkdir -p $VIMDIR/files
    (cd $VIMDIR/files && mkdir undo backup info swap)
fi 
