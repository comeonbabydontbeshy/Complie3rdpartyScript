PackageUnzipPath=$1
Architecture=$2
Variant=$3
Link=$4
Compiler=$5
OutputPath=$6

cflagsParam="-O2 "
if [ $Variant == "debug" ]
then 
    cflagsParam=$cflagsParam"-g "
fi

# gcc -c -Q -march=native --help=target
if [ $Architecture == "x86" ]
then 
    cflagsParam=$Architecture" -march=-m64"
fi


cd ${PackageUnzipPath}
CXXFLAGS="$cflagsParam" ./configure --prefix=${OutputPath}
cd ./src/interfaces/libpq/
make 
make install