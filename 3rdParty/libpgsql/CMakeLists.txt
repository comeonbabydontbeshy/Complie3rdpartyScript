# 获取第三方库名
STRING(FIND ${CMAKE_CURRENT_BINARY_DIR} "/" POS REVERSE)
STRING(LENGTH ${CMAKE_CURRENT_BINARY_DIR} LEN)
MATH(EXPR START ${POS}+1)
MATH(EXPR CUTLEN ${LEN}-${POS}-1)
STRING(SUBSTRING ${CMAKE_CURRENT_BINARY_DIR} ${START} ${CUTLEN} 3rdPartyName)
MESSAGE(STATUS "3rdPartyName : ${3rdPartyName}")

# 解压目录
FILE(GLOB Package *.tar.gz *.zip)
FOREACH(pack ${Package})
    MESSAGE(STATUS "package name : ${pack}")
    GET_FILENAME_COMPONENT(FileName ${pack} NAME_WE)
    GET_FILENAME_COMPONENT(ExtName ${pack} EXT)
    SET(PackageUnzipName ${FileName})
    IF (${pack} MATCHES "tar.gz")
        EXECUTE_PROCESS(COMMAND tar xvf ${pack} 
                        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
                        RESULT_VARIABLE UnzipRet)
    ENDIF (${pack} MATCHES "*.tar.gz")
    IF (${pack} MATCHES "zip")
        EXECUTE_PROCESS(COMMAND unzip ${pack} 
                        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
                        RESULT_VARIABLE UnzipRet)
    ENDIF (${pack} MATCHES "*.tar.gz")
    IF (${UnzipRet} EQUAL "0")
        MESSAGE(STATUS "success to unzip ${pack}")
    ELSE (${UnzipRet} EQUAL "0")
        MESSAGE(FATAL_ERROR "fail to unzip ${pack} , ret : ${UnzipRet}")
    ENDIF (${UnzipRet} EQUAL "0")
ENDFOREACH(pack)

# 编译第三方库
SET(ScriptPath "${CMAKE_CURRENT_BINARY_DIR}/make_${3rdPartyName}.sh")
SET(PackageUnzipPath "${CMAKE_CURRENT_BINARY_DIR}/${PackageUnzipName}")
SET(Link "static")
SET(Compiler "gcc")
SET(OutputPath "${CMAKE_SOURCE_DIR}/release")

MESSAGE(STATUS "ScriptPath : ${ScriptPath}")
MESSAGE(STATUS "PackageUnzipPath : ${PackageUnzipPath}")
MESSAGE(STATUS "Architecture : ${Architecture}")
MESSAGE(STATUS "build type : ${CMAKE_BUILD_TYPE}")
MESSAGE(STATUS "Link : ${Link}")
MESSAGE(STATUS "Compiler : ${Compiler}")
MESSAGE(STATUS "OutputPath : ${OutputPath}")

EXECUTE_PROCESS(COMMAND sh ${ScriptPath} ${PackageUnzipPath} ${Architecture} ${CMAKE_BUILD_TYPE} ${Link} ${Compiler} ${OutputPath}
                WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
                RESULT_VARIABLE ret)
                
IF (${ret} EQUAL "0")
    MESSAGE(STATUS "success to compile ${3rdPartyName}")
ELSE (${ret} EQUAL "0")
    MESSAGE(FATAL_ERROR "fail to compile ${3rdPartyName} , ret : ${ret}")
ENDIF (${ret} EQUAL "0")