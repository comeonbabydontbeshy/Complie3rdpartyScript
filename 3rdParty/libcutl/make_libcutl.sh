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

cflagsParam=${cflagsParam}" -I${OutputPath}/include"

cd ${PackageUnzipPath}
CXXFLAGS="$cflagsParam" LDFLAGS="-L${OutputPath}/lib" ./configure --prefix=${OutputPath} --enable-static --disable-shared --disable-threads 
make 
make install