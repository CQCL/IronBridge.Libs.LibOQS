
TARBALL_URL = https://github.com/open-quantum-safe/liboqs/archive
TARBALL_FILENAME = 0.4.0.tar.gz
TARBALL_CHECKSUM = 05836cd2b5c70197b3b6eed68b97d0ccb2c445061d5c19c15aef7c959842de0b
EXTRACTED_FOLDER = liboqs-0.4.0

ALL: \
     srcs/$(EXTRACTED_FOLDER)/build/lib/liboqs.so \
     /usr/local/lib/liboqs.so
	@echo $@ Done

GET_TOOLS:
	#sudo apt update
	sudo apt install --no-install-recommends -yV build-essential ninja-build wget cmake
	@echo $@ Done

$(TARBALL_FILENAME):
	wget $(TARBALL_URL)/$(TARBALL_FILENAME)
	@echo "$(TARBALL_CHECKSUM) $(TARBALL_FILENAME)" | sha256sum --check --status
	@echo $@ Done

srcs/$(EXTRACTED_FOLDER)/CMakeLists.txt: $(TARBALL_FILENAME)
	mkdir -p srcs
	cd srcs && tar -zxf ../$(TARBALL_FILENAME) && cd ..
	@echo "Change the modification time of our trigger file: srcs/$(EXTRACTED_FOLDER)/CMakeLists.txt"
	touch -m --no-create srcs/$(EXTRACTED_FOLDER)/CMakeLists.txt
	@echo $@ Done

srcs/$(EXTRACTED_FOLDER)/build/build.ninja: srcs/$(EXTRACTED_FOLDER)/CMakeLists.txt
	mkdir -p srcs/$(EXTRACTED_FOLDER)/build
	cd srcs/$(EXTRACTED_FOLDER)/build && cmake -DBUILD_SHARED_LIBS=ON -GNinja ..
	@echo "Change the modification time of our trigger file: srcs/$(EXTRACTED_FOLDER)/build/build.ninja"
	touch -m --no-create srcs/$(EXTRACTED_FOLDER)/build/build.ninja
	@echo $@ Done

# ninja --quiet option will be supported from Ninja 1.11.0

srcs/$(EXTRACTED_FOLDER)/build/lib/liboqs.so: srcs/$(EXTRACTED_FOLDER)/build/build.ninja
	cd srcs/$(EXTRACTED_FOLDER)/build && ninja
	@echo $@ Done

/usr/local/lib/liboqs.so: srcs/$(EXTRACTED_FOLDER)/build/lib/liboqs.so
	cd srcs/$(EXTRACTED_FOLDER)/build && sudo ninja install
	@echo $@ Done

CLEAN:
	if [ -d "srcs/$(EXTRACTED_FOLDER)/build" ]; then rm -rf "srcs/$(EXTRACTED_FOLDER)/build"; fi
	if [ -d "srcs/$(EXTRACTED_FOLDER)" ]; then rm -rf "srcs/$(EXTRACTED_FOLDER)"; fi
	if [ -d "srcs" ]; then rm -rf "srcs"; fi
	if [ -f $(TARBALL_FILENAME) ]; then rm $(TARBALL_FILENAME); fi
	@echo $@ Done


# [0/1] Install the project...
# -- Install configuration: ""
# -- Installing: /usr/local/lib/liboqs.so.0.4.0
# -- Up-to-date: /usr/local/lib/liboqs.so.0
# -- Up-to-date: /usr/local/lib/liboqs.so
# -- Up-to-date: /usr/local/include/oqs/oqs.h
# -- Up-to-date: /usr/local/include/oqs/common.h
# -- Up-to-date: /usr/local/include/oqs/rand.h
# -- Up-to-date: /usr/local/include/oqs/aes.h
# -- Up-to-date: /usr/local/include/oqs/sha2.h
# -- Up-to-date: /usr/local/include/oqs/sha3.h
# -- Up-to-date: /usr/local/include/oqs/kem.h
# -- Up-to-date: /usr/local/include/oqs/sig.h
# -- Up-to-date: /usr/local/include/oqs/kem_bike.h
# -- Up-to-date: /usr/local/include/oqs/kem_frodokem.h
# -- Up-to-date: /usr/local/include/oqs/kem_sike.h
# -- Up-to-date: /usr/local/include/oqs/sig_picnic.h
# -- Up-to-date: /usr/local/include/oqs/sig_qtesla.h
# -- Up-to-date: /usr/local/include/oqs/kem_classic_mceliece.h
# -- Up-to-date: /usr/local/include/oqs/kem_hqc.h
# -- Up-to-date: /usr/local/include/oqs/kem_kyber.h
# -- Up-to-date: /usr/local/include/oqs/kem_newhope.h
# -- Up-to-date: /usr/local/include/oqs/kem_ntru.h
# -- Up-to-date: /usr/local/include/oqs/kem_saber.h
# -- Up-to-date: /usr/local/include/oqs/kem_threebears.h
# -- Up-to-date: /usr/local/include/oqs/sig_dilithium.h
# -- Up-to-date: /usr/local/include/oqs/sig_falcon.h
# -- Up-to-date: /usr/local/include/oqs/sig_mqdss.h
# -- Up-to-date: /usr/local/include/oqs/sig_rainbow.h
# -- Up-to-date: /usr/local/include/oqs/sig_sphincs.h
# -- Installing: /usr/local/include/oqs/oqsconfig.h


MAYBE_GET_TOOLS:
	sudo apt update
	##############################################
	REQUIRED_PKG="build-essential"
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' "${REQUIRED_PKG}" | grep "install ok installed")
	@echo "Checking for ${REQUIRED_PKG}: ${PKG_OK}"
	if [ "${PKG_OK}" == "" ]; then
	  echo "Package not found. Installing ${REQUIRED_PKG} ..."
	  sudo apt-get --yes install "${REQUIRED_PKG}"
	fi
	##############################################
	REQUIRED_PKG = "wget"
	PKG_OK = $(dpkg-query -W --showformat='${Status}\n' "${REQUIRED_PKG}" | grep "install ok installed")
	@echo "Checking for ${REQUIRED_PKG}: ${PKG_OK}"
	if [ "$PKG_OK" == "" ]; then
	  echo "Package not found. Installing ${REQUIRED_PKG} ..."
	  sudo apt-get --yes install "${REQUIRED_PKG}"
	fi
	##############################################
	REQUIRED_PKG = "cmake"
	PKG_OK = $(dpkg-query -W --showformat='${Status}\n' "${REQUIRED_PKG}" | grep "install ok installed")
	@echo "Checking for ${REQUIRED_PKG}: ${PKG_OK}"
	if [ "$PKG_OK" == "" ]; then
	  echo "Package not found. Installing ${REQUIRED_PKG} ..."
	  sudo apt-get --yes install "${REQUIRED_PKG}"
	fi
	##############################################
	REQUIRED_PKG = "ninja-build"
	PKG_OK = $(dpkg-query -W --showformat='${Status}\n' "${REQUIRED_PKG}" | grep "install ok installed")
	@echo "Checking for ${REQUIRED_PKG}: ${PKG_OK}"
	if [ "$PKG_OK" == "" ]; then
	  echo "Package not found. Installing ${REQUIRED_PKG} ..."
	  sudo apt-get --yes install "${REQUIRED_PKG}"
	fi
	##############################################
	@echo $@ Done

all: ALL

build: ALL

clean: CLEAN

buildall: GET_TOOLS ALL

rebuild: CLEAN ALL

rebuildall: GET_TOOLS CLEAN ALL

get_tools: GET_TOOLS

install_deps: GET_TOOLS

