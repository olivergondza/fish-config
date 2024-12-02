function podman_ls -a image_name -d "List file in the container"
    buildah unshare fish -c "
        set ctr (buildah from $image_name)
        set mnt (buildah mount \$ctr)
        cd \$mnt
        find .
        buildah unmount \$ctr
        buildah rm \$ctr
    "
end
