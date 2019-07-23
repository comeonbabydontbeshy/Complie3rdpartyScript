PackageUnzipPath=$1
PackageUnzipPath=${PackageUnzipPath}".10.0"
Architecture=$2
Variant=$3
Link=$4
Compiler=$5
OutputPath=$6

cflagsParam="-O3 "
if [ $Variant == "debug" ]
then 
    cflagsParam=$cflagsParam"-g "
fi

cd ${PackageUnzipPath}
CXXFLAGS="$cflagsParam" ./configure --prefix=${OutputPath} --enable-static --disable-shared --disable-threads 
#--with-boost=${OutputPath}
make 
make install