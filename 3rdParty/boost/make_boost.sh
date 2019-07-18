PackageUnzipPath=$1
Architecture=$2
Variant=$3
Link=$4
Compiler=$5
OutputPath=$6

cd ${PackageUnzipPath}
./bootstrap.sh --with-toolset=${Compiler} --prefix=${OutputPath}
./b2 --variant=${Variant} --link=${Link} --threading=multi --runtime-link=static --architecture=${Architecture} --without-python --without-mpi --without-wave --without-graph --without-math install