# generated using pypi2nix tool (version: 2.0.0)
# See more at: https://github.com/nix-community/pypi2nix
#
# COMMAND:
#   pypi2nix -r requirements.txt
#

{ pkgs ? import <nixpkgs> {},
  overrides ? ({ pkgs, python }: self: super: {})
}:

let

  inherit (pkgs) makeWrapper;
  inherit (pkgs.stdenv.lib) fix' extends inNixShell;

  pythonPackages =
  import "${toString pkgs.path}/pkgs/top-level/python-packages.nix" {
    inherit pkgs;
    inherit (pkgs) stdenv;
    python = pkgs.python3;
    # patching pip so it does not try to remove files when running nix-shell
    overrides =
      self: super: {
        bootstrapped-pip = super.bootstrapped-pip.overrideDerivation (old: {
          patchPhase = (if builtins.hasAttr "patchPhase" old then old.patchPhase else "") + ''
            if [ -e $out/${pkgs.python3.sitePackages}/pip/req/req_install.py ]; then
              sed -i \
                -e "s|paths_to_remove.remove(auto_confirm)|#paths_to_remove.remove(auto_confirm)|"  \
                -e "s|self.uninstalled = paths_to_remove|#self.uninstalled = paths_to_remove|"  \
                $out/${pkgs.python3.sitePackages}/pip/req/req_install.py
            fi
          '';
        });
      };
  };

  commonBuildInputs = [];
  commonDoCheck = false;

  withPackages = pkgs':
    let
      pkgs = builtins.removeAttrs pkgs' ["__unfix__"];
      interpreterWithPackages = selectPkgsFn: pythonPackages.buildPythonPackage {
        name = "python3-interpreter";
        buildInputs = [ makeWrapper ] ++ (selectPkgsFn pkgs);
        buildCommand = ''
          mkdir -p $out/bin
          ln -s ${pythonPackages.python.interpreter} \
              $out/bin/${pythonPackages.python.executable}
          for dep in ${builtins.concatStringsSep " "
              (selectPkgsFn pkgs)}; do
            if [ -d "$dep/bin" ]; then
              for prog in "$dep/bin/"*; do
                if [ -x "$prog" ] && [ -f "$prog" ]; then
                  ln -s $prog $out/bin/`basename $prog`
                fi
              done
            fi
          done
          for prog in "$out/bin/"*; do
            wrapProgram "$prog" --prefix PYTHONPATH : "$PYTHONPATH"
          done
          pushd $out/bin
          ln -s ${pythonPackages.python.executable} python
          ln -s ${pythonPackages.python.executable} \
              python3
          popd
        '';
        passthru.interpreter = pythonPackages.python;
      };

      interpreter = interpreterWithPackages builtins.attrValues;
    in {
      __old = pythonPackages;
      inherit interpreter;
      inherit interpreterWithPackages;
      mkDerivation = args: pythonPackages.buildPythonPackage (args // {
        nativeBuildInputs = (args.nativeBuildInputs or []) ++ args.buildInputs;
      });
      packages = pkgs;
      overrideDerivation = drv: f:
        pythonPackages.buildPythonPackage (
          drv.drvAttrs // f drv.drvAttrs // { meta = drv.meta; }
        );
      withPackages = pkgs'':
        withPackages (pkgs // pkgs'');
    };

  python = withPackages {};

  generated = self: {
    "cachetools" = python.mkDerivation {
      name = "cachetools-4.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/30/62/88fda08df9053141647b6941141b71b4c2a23d0fabab485feb917428ab46/cachetools-4.1.0.tar.gz";
        sha256 = "1d057645db16ca7fe1f3bd953558897603d6f0b9c51ed9d11eb4d071ec4e2aab";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/tkem/cachetools/";
        license = licenses.mit;
        description = "Extensible memoizing collections and decorators";
      };
    };

    "census" = python.mkDerivation {
      name = "census-0.8.13";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/7e/82/5c1a2e6e8ca3730155a3cf4e312ad8885fd4832a3956a19d7845368dc21b/census-0.8.13.tar.gz";
        sha256 = "ab4f4bb2e7228e688f1de77e693b2e7a10fbab257fd24a616e86fa0cebf6145e";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."future"
        self."requests"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/datamade/census";
        license = licenses.bsdOriginal;
        description = "A wrapper for the US Census Bureau's API";
      };
    };

    "certifi" = python.mkDerivation {
      name = "certifi-2020.4.5.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/b8/e2/a3a86a67c3fc8249ed305fc7b7d290ebe5e4d46ad45573884761ef4dea7b/certifi-2020.4.5.1.tar.gz";
        sha256 = "51fcb31174be6e6664c5f69e3e1691a2d72a1a12e90f872cbdb1567eb47b6519";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://certifiio.readthedocs.io/en/latest/";
        license = licenses.mpl20;
        description = "Python package for providing Mozilla's CA Bundle.";
      };
    };

    "chardet" = python.mkDerivation {
      name = "chardet-3.0.4";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz";
        sha256 = "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/chardet/chardet";
        license = licenses.lgpl3;
        description = "Universal encoding detector for Python 2 and 3";
      };
    };

    "duckduckpy" = python.mkDerivation {
      name = "duckduckpy-0.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/e0/7a/b186c3e372217edf3573844cdf5d9c22f11d147ec8d46f04982b40b4f4f1/duckduckpy-0.2.tar.bz2";
        sha256 = "608c2972efc375d3af88fef12a182e62bd8e3f971fc1e51877a2f636599e18b8";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/ivankliuk/duckduckpy/";
        license = licenses.mit;
        description = "Library for querying the instant answer API of DuckDuckGo search engine.";
      };
    };

    "future" = python.mkDerivation {
      name = "future-0.18.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/45/0b/38b06fd9b92dc2b68d58b75f900e97884c45bedd2ff83203d933cf5851c9/future-0.18.2.tar.gz";
        sha256 = "b1bead90b70cf6ec3f0710ae53a525360fa360d306a86583adc6bf83a4db537d";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://python-future.org";
        license = licenses.mit;
        description = "Clean single-source support for Python 3 and 2";
      };
    };

    "google-api-core" = python.mkDerivation {
      name = "google-api-core-1.16.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/b9/c6/b9483b94e85e4088198bc99c807a6a458800d278ae49f79a0dee0cfdc171/google-api-core-1.16.0.tar.gz";
        sha256 = "92e962a087f1c4b8d1c5c88ade1c1dfd550047dcffb320c57ef6a534a20403e2";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."google-auth"
        self."googleapis-common-protos"
        self."protobuf"
        self."pytz"
        self."requests"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/GoogleCloudPlatform/google-cloud-python";
        license = licenses.asl20;
        description = "Google API client core library";
      };
    };

    "google-api-python-client" = python.mkDerivation {
      name = "google-api-python-client-1.8.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/50/94/e30a5118dbb178d8ea4bde737e7722209b7018349a2fbdadadc159ba931c/google-api-python-client-1.8.0.tar.gz";
        sha256 = "0f5b42a14e2d2f7dee40f2e4514531dbe95ebde9c2173b1c4040a65c427e7900";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."google-api-core"
        self."google-auth"
        self."google-auth-httplib2"
        self."httplib2"
        self."six"
        self."uritemplate"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/google/google-api-python-client/";
        license = licenses.asl20;
        description = "Google API Client Library for Python";
      };
    };

    "google-auth" = python.mkDerivation {
      name = "google-auth-1.13.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/b5/e6/953b6afdb2e43c245067bb51940df21d1192451ba725c9093e1fafcefbae/google-auth-1.13.1.tar.gz";
        sha256 = "a5ee4c40fef77ea756cf2f1c0adcf475ecb53af6700cf9c133354cdc9b267148";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."cachetools"
        self."pyasn1-modules"
        self."rsa"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/googleapis/google-auth-library-python";
        license = licenses.asl20;
        description = "Google Authentication Library";
      };
    };

    "google-auth-httplib2" = python.mkDerivation {
      name = "google-auth-httplib2-0.0.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/e7/32/ac7f30b742276b4911a1439c5291abab1b797ccfd30bc923c5ad67892b13/google-auth-httplib2-0.0.3.tar.gz";
        sha256 = "098fade613c25b4527b2c08fa42d11f3c2037dda8995d86de0745228e965d445";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."google-auth"
        self."httplib2"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/GoogleCloudPlatform/google-auth-library-python-httplib2";
        license = licenses.asl20;
        description = "Google Authentication Library: httplib2 transport";
      };
    };

    "googleapis-common-protos" = python.mkDerivation {
      name = "googleapis-common-protos-1.51.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/05/46/168fd780f594a4d61122f7f3dc0561686084319ad73b4febbf02ae8b32cf/googleapis-common-protos-1.51.0.tar.gz";
        sha256 = "013c91704279119150e44ef770086fdbba158c1f978a6402167d47d5409e226e";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."protobuf"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/googleapis/googleapis";
        license = "Apache-2.0";
        description = "Common protobufs used in Google APIs";
      };
    };

    "googlemaps" = python.mkDerivation {
      name = "googlemaps-4.2.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/56/ed/aac1e3c8f7dc3339912cc893465b9277370b4d23d87095b8d6317f9a4fb0/googlemaps-4.2.0.tar.gz";
        sha256 = "511b2c20842d812d4fa03d70e4264147dd7fd6b88ee0819e502934329c4ac454";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."requests"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/googlemaps/google-maps-services-python";
        license = licenses.asl20;
        description = "Python client library for Google Maps Platform";
      };
    };

    "httplib2" = python.mkDerivation {
      name = "httplib2-0.17.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/65/4c/c0d95b6d6904f04e306c3a92d949fe53198c62c5a3a0a0d10298ad6e5d1e/httplib2-0.17.1.tar.gz";
        sha256 = "b81b2cd2248285168a4359f2acf24521a4099b5853e790309c45dcb90ee4b3c6";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/httplib2/httplib2";
        license = licenses.mit;
        description = "A comprehensive HTTP client library.";
      };
    };

    "idna" = python.mkDerivation {
      name = "idna-2.9";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/cb/19/57503b5de719ee45e83472f339f617b0c01ad75cba44aba1e4c97c2b0abd/idna-2.9.tar.gz";
        sha256 = "7588d1c14ae4c77d74036e8c22ff447b26d0fde8f007354fd48a7814db15b7cb";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kjd/idna";
        license = licenses.bsdOriginal;
        description = "Internationalized Domain Names in Applications (IDNA)";
      };
    };

    "jellyfish" = python.mkDerivation {
      name = "jellyfish-0.5.6";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/94/48/ddb1458d966f0a84e472d059d87a9d1527df7768a725132fc1d810728386/jellyfish-0.5.6.tar.gz";
        sha256 = "887a9a49d0caee913a883c3e7eb185f6260ebe2137562365be422d1316bd39c9";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/jamesturk/jellyfish";
        license = "UNKNOWN";
        description = "a library for doing approximate and phonetic matching of strings.";
      };
    };

    "protobuf" = python.mkDerivation {
      name = "protobuf-3.11.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/c9/d5/e6e789e50e478463a84bd1cdb45aa408d49a2e1aaffc45da43d10722c007/protobuf-3.11.3.tar.gz";
        sha256 = "c77c974d1dadf246d789f6dad1c24426137c9091e930dbf50e0a29c1fcf00b1f";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://developers.google.com/protocol-buffers/";
        license = licenses.bsd3;
        description = "Protocol Buffers";
      };
    };

    "pyasn1" = python.mkDerivation {
      name = "pyasn1-0.4.8";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/a4/db/fffec68299e6d7bad3d504147f9094830b704527a7fc098b721d38cc7fa7/pyasn1-0.4.8.tar.gz";
        sha256 = "aef77c9fb94a3ac588e87841208bdec464471d9871bd5050a287cc9a475cd0ba";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/etingof/pyasn1";
        license = licenses.bsdOriginal;
        description = "ASN.1 types and codecs";
      };
    };

    "pyasn1-modules" = python.mkDerivation {
      name = "pyasn1-modules-0.2.8";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/88/87/72eb9ccf8a58021c542de2588a867dbefc7556e14b2866d1e40e9e2b587e/pyasn1-modules-0.2.8.tar.gz";
        sha256 = "905f84c712230b2c592c19470d3ca8d552de726050d1d1716282a1f6146be65e";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."pyasn1"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/etingof/pyasn1-modules";
        license = "BSD-2-Clause";
        description = "A collection of ASN.1-based protocols modules.";
      };
    };

    "pytz" = python.mkDerivation {
      name = "pytz-2019.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/82/c3/534ddba230bd4fbbd3b7a3d35f3341d014cca213f369a9940925e7e5f691/pytz-2019.3.tar.gz";
        sha256 = "b02c06db6cf09c12dd25137e563b31700d3b80fcc4ad23abb7a315f2789819be";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pythonhosted.org/pytz";
        license = licenses.mit;
        description = "World timezone definitions, modern and historical";
      };
    };

    "requests" = python.mkDerivation {
      name = "requests-2.23.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/f5/4f/280162d4bd4d8aad241a21aecff7a6e46891b905a4341e7ab549ebaf7915/requests-2.23.0.tar.gz";
        sha256 = "b3f43d496c6daba4493e7c431722aeb7dbc6288f52a6e04e7b6023b0247817e6";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."certifi"
        self."chardet"
        self."idna"
        self."urllib3"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://requests.readthedocs.io";
        license = licenses.asl20;
        description = "Python HTTP for Humans.";
      };
    };

    "rsa" = python.mkDerivation {
      name = "rsa-4.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/cb/d0/8f99b91432a60ca4b1cd478fd0bdf28c1901c58e3a9f14f4ba3dba86b57f/rsa-4.0.tar.gz";
        sha256 = "1a836406405730121ae9823e19c6e806c62bbad73f890574fff50efa4122c487";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."pyasn1"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://stuvel.eu/rsa";
        license = "ASL 2";
        description = "Pure-Python RSA implementation";
      };
    };

    "six" = python.mkDerivation {
      name = "six-1.14.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/21/9f/b251f7f8a76dec1d6651be194dfba8fb8d7781d10ab3987190de8391d08e/six-1.14.0.tar.gz";
        sha256 = "236bdbdce46e6e6a3d61a337c0f8b763ca1e8717c03b369e87a7ec7ce1319c0a";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/benjaminp/six";
        license = licenses.mit;
        description = "Python 2 and 3 compatibility utilities";
      };
    };

    "uritemplate" = python.mkDerivation {
      name = "uritemplate-3.0.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/42/da/fa9aca2d866f932f17703b3b5edb7b17114bb261122b6e535ef0d9f618f8/uritemplate-3.0.1.tar.gz";
        sha256 = "5af8ad10cec94f215e3f48112de2022e1d5a37ed427fbd88652fa908f2ab7cae";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://uritemplate.readthedocs.org";
        license = "BSD 3-Clause License or Apache License, Version 2.0";
        description = "URI templates";
      };
    };

    "urllib3" = python.mkDerivation {
      name = "urllib3-1.25.8";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/09/06/3bc5b100fe7e878d3dee8f807a4febff1a40c213d2783e3246edde1f3419/urllib3-1.25.8.tar.gz";
        sha256 = "87716c2d2a7121198ebcb7ce7cccf6ce5e9ba539041cfbaeecfb641dc0bf6acc";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://urllib3.readthedocs.io/";
        license = licenses.mit;
        description = "HTTP library with thread-safe connection pooling, file post, and more.";
      };
    };

    "us" = python.mkDerivation {
      name = "us-1.0.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/72/83/8731cbf5afcf3434c0b24cfc520c11fd27bfc8a6878114662f4e3dbdab71/us-1.0.0.tar.gz";
        sha256 = "09dc9ba763e2e4399e6a042104f3e415a7de6bfa4df6f557b4f19e3ba9a22fda";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."jellyfish"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/unitedstates/python-us";
        license = licenses.bsdOriginal;
        description = "US state meta information and other fun stuff";
      };
    };
  };
  localOverridesFile = ./requirements_override.nix;
  localOverrides = import localOverridesFile { inherit pkgs python; };
  commonOverrides = [
    
  ];
  paramOverrides = [
    (overrides { inherit pkgs python; })
  ];
  allOverrides =
    (if (builtins.pathExists localOverridesFile)
     then [localOverrides] else [] ) ++ commonOverrides ++ paramOverrides;

in python.withPackages
   (fix' (pkgs.lib.fold
            extends
            generated
            allOverrides
         )
   )