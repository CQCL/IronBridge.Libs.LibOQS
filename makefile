

ALL: \
     GET_TOOLS \
     GET_SRCS \
     DO_BUILD \
     DO_INSTALL
	echo $@ Done.

GET_TOOLS:
	sudo apt update
	sudo apt install --no-install-recommends -yV build-essential ninja-build wget cmake
	echo $@ Done.

GET_SRCS: 
	mkdir -p srcs
	if [ ! -f 0.4.0.tar.gz ]; then wget https://github.com/open-quantum-safe/liboqs/archive/0.4.0.tar.gz && \
	                               echo "05836cd2b5c70197b3b6eed68b97d0ccb2c445061d5c19c15aef7c959842de0b 0.4.0.tar.gz" | sha256sum --check --status; fi
	if [ ! -f srcs/liboqs-0.4.0/CMakeLists.txt ]; then cd srcs && tar -zxvf ../0.4.0.tar.gz && cd ..; fi 
	echo $@ Done.

DO_BUILD:
	mkdir -p srcs/liboqs-0.4.0/build
	#if [ ! -f srcs/liboqs-0.4.0/build/build.ninja ]; then cd srcs/liboqs-0.4.0/build && cmake -DBUILD_SHARED_LIBS=OFF -GNinja ..; fi
	#if [ ! -f srcs/liboqs-0.4.0/build/lib/liboqs.a ]; then cd srcs/liboqs-0.4.0/build && ninja; fi
	if [ ! -f srcs/liboqs-0.4.0/build/build.ninja ]; then cd srcs/liboqs-0.4.0/build && cmake -DBUILD_SHARED_LIBS=ON -GNinja ..; fi
	#if [ ! -f srcs/liboqs-0.4.0/build/lib/liboqs.so ]; then cd srcs/liboqs-0.4.0/build && ninja; fi
	cd srcs/liboqs-0.4.0/build && ninja
	echo $@ Done.

DO_INSTALL:
	cd srcs/liboqs-0.4.0/build && sudo ninja install

CLEAN:
	if [ -d "srcs/liboqs-0.4.0/build" ]; then rm -rf "srcs/liboqs-0.4.0/build"; fi
	if [ -d "srcs/liboqs-0.4.0" ]; then rm -rf "srcs/liboqs-0.4.0"; fi
	if [ -f 0.4.0.tar.gz ]; then rm 0.4.0.tar.gz; fi


# [0/1] Install the project...
# -- Install configuration: ""
# -- Installing: /usr/local/lib/liboqs.a
# -- Installing: /usr/local/include/oqs/oqs.h
# -- Installing: /usr/local/include/oqs/common.h
# -- Installing: /usr/local/include/oqs/rand.h
# -- Installing: /usr/local/include/oqs/aes.h
# -- Installing: /usr/local/include/oqs/sha2.h
# -- Installing: /usr/local/include/oqs/sha3.h
# -- Installing: /usr/local/include/oqs/kem.h
# -- Installing: /usr/local/include/oqs/sig.h
# -- Installing: /usr/local/include/oqs/kem_bike.h
# -- Installing: /usr/local/include/oqs/kem_frodokem.h
# -- Installing: /usr/local/include/oqs/kem_sike.h
# -- Installing: /usr/local/include/oqs/sig_picnic.h
# -- Installing: /usr/local/include/oqs/sig_qtesla.h
# -- Installing: /usr/local/include/oqs/kem_classic_mceliece.h
# -- Installing: /usr/local/include/oqs/kem_hqc.h
# -- Installing: /usr/local/include/oqs/kem_kyber.h
# -- Installing: /usr/local/include/oqs/kem_newhope.h
# -- Installing: /usr/local/include/oqs/kem_ntru.h
# -- Installing: /usr/local/include/oqs/kem_saber.h
# -- Installing: /usr/local/include/oqs/kem_threebears.h
# -- Installing: /usr/local/include/oqs/sig_dilithium.h
# -- Installing: /usr/local/include/oqs/sig_falcon.h
# -- Installing: /usr/local/include/oqs/sig_mqdss.h
# -- Installing: /usr/local/include/oqs/sig_rainbow.h
# -- Installing: /usr/local/include/oqs/sig_sphincs.h
# -- Installing: /usr/local/include/oqs/oqsconfig.h

MAYBE_GET_TOOLS:
	sudo apt update
	##############################################
	REQUIRED_PKG="build-essential"
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' "${REQUIRED_PKG}" | grep "install ok installed")
	echo "Checking for ${REQUIRED_PKG}: ${PKG_OK}"
	if [ "${PKG_OK}" == "" ]; then
	  echo "Package not found. Installing ${REQUIRED_PKG} ..."
	  sudo apt-get --yes install "${REQUIRED_PKG}"
	fi
	##############################################
	REQUIRED_PKG = "wget"
	PKG_OK = $(dpkg-query -W --showformat='${Status}\n' "${REQUIRED_PKG}" | grep "install ok installed")
	echo "Checking for ${REQUIRED_PKG}: ${PKG_OK}"
	if [ "$PKG_OK" == "" ]; then
	  echo "Package not found. Installing ${REQUIRED_PKG} ..."
	  sudo apt-get --yes install "${REQUIRED_PKG}"
	fi
	##############################################
	REQUIRED_PKG = "cmake"
	PKG_OK = $(dpkg-query -W --showformat='${Status}\n' "${REQUIRED_PKG}" | grep "install ok installed")
	echo "Checking for ${REQUIRED_PKG}: ${PKG_OK}"
	if [ "$PKG_OK" == "" ]; then
	  echo "Package not found. Installing ${REQUIRED_PKG} ..."
	  sudo apt-get --yes install "${REQUIRED_PKG}"
	fi
	##############################################
	REQUIRED_PKG = "ninja-build"
	PKG_OK = $(dpkg-query -W --showformat='${Status}\n' "${REQUIRED_PKG}" | grep "install ok installed")
	echo "Checking for ${REQUIRED_PKG}: ${PKG_OK}"
	if [ "$PKG_OK" == "" ]; then
	  echo "Package not found. Installing ${REQUIRED_PKG} ..."
	  sudo apt-get --yes install "${REQUIRED_PKG}"
	fi
	##############################################
	echo $@ Done.

