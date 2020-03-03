# Created by: Christopher Hall <hsw@bitmark.com>
# $FreeBSD$

PORTNAME=	bitmark-wallet
PORTVERSION=	0.6.4
DISTVERSIONPREFIX=	v
CATEGORIES=	finance

MAINTAINER=	jim@bitmark.com
COMMENT=	Bitmark HD Wallet

LICENSE=	ISCL
LICENSE_FILE=	${WRKSRC}/LICENSE

USES=		pkgconfig go:modules

USE_GITHUB=	yes
GH_ACCOUNT=	bitmark-inc:DEFAULT
GH_TUPLE=	\
		NebulousLabs:entropy-mnemonics:bc7e13c5ccd8:nebulouslabs_entropy_mnemonics/vendor/github.com/NebulousLabs/entropy-mnemonics \
		bitgoin:address:v0.0.1:bitgoin_address/vendor/github.com/bitgoin/address \
		bitgoin:packer:v0.0.1:bitgoin_packer/vendor/github.com/bitgoin/packer \
		bitmark-inc:bitmarkd:v0.12.4:bitmark_inc_bitmarkd/vendor/github.com/bitmark-inc/bitmarkd \
		bitmark-inc:logger:v0.3.4:bitmark_inc_logger/vendor/github.com/bitmark-inc/logger \
		boltdb:bolt:v1.3.1:boltdb_bolt/vendor/github.com/boltdb/bolt \
		btcsuite:fastsha256:637e65642941:btcsuite_fastsha256/vendor/github.com/btcsuite/fastsha256 \
		cihub:seelog:f561c5e57575:cihub_seelog/vendor/github.com/cihub/seelog \
		davecgh:go-spew:v1.1.1:davecgh_go_spew/vendor/github.com/davecgh/go-spew \
		fsnotify:fsnotify:v1.4.7:fsnotify_fsnotify/vendor/github.com/fsnotify/fsnotify \
		go-ini:ini:v1.51.0:go_ini_ini/vendor/gopkg.in/ini.v1 \
		go-yaml:yaml:v2.2.4:go_yaml_yaml/vendor/gopkg.in/yaml.v2 \
		golang:crypto:2aa609cf4a9d:golang_crypto/vendor/golang.org/x/crypto \
		golang:sys:749cb33beabd:golang_sys/vendor/golang.org/x/sys \
		golang:text:v0.3.2:golang_text/vendor/golang.org/x/text \
		hashicorp:hcl:v1.0.0:hashicorp_hcl/vendor/github.com/hashicorp/hcl \
		inconshreveable:mousetrap:v1.0.0:inconshreveable_mousetrap/vendor/github.com/inconshreveable/mousetrap \
		magiconair:properties:v1.8.1:magiconair_properties/vendor/github.com/magiconair/properties \
		mitchellh:mapstructure:v1.1.2:mitchellh_mapstructure/vendor/github.com/mitchellh/mapstructure \
		pelletier:go-toml:v1.2.0:pelletier_go_toml/vendor/github.com/pelletier/go-toml \
		pmezard:go-difflib:v1.0.0:pmezard_go_difflib/vendor/github.com/pmezard/go-difflib \
		spf13:afero:v1.1.2:spf13_afero/vendor/github.com/spf13/afero \
		spf13:cast:v1.3.0:spf13_cast/vendor/github.com/spf13/cast \
		spf13:cobra:v0.0.6:spf13_cobra/vendor/github.com/spf13/cobra \
		spf13:jwalterweatherman:v1.0.0:spf13_jwalterweatherman/vendor/github.com/spf13/jwalterweatherman \
		spf13:pflag:v1.0.5:spf13_pflag/vendor/github.com/spf13/pflag \
		spf13:viper:v1.6.2:spf13_viper/vendor/github.com/spf13/viper \
		stretchr:testify:v1.4.0:stretchr_testify/vendor/github.com/stretchr/testify \
		subosito:gotenv:v1.2.0:subosito_gotenv/vendor/github.com/subosito/gotenv

SHARE_FILES=	README.md
PLIST_FILES=	bin/${PORTNAME}
PLIST_FILES+=	"@sample etc/${PORTNAME}.conf.sample"

GO_TARGET+=	./command/${PORTNAME}

do-install:
	${INSTALL_PROGRAM} ${WRKDIR}/bin/${PORTNAME} ${STAGEDIR}${PREFIX}/bin
	${INSTALL_DATA} ${WRKSRC}/command/${PORTNAME}/wallet.conf.sample ${STAGEDIR}${PREFIX}/etc/${PORTNAME}.conf.sample

.include <bsd.port.mk>
