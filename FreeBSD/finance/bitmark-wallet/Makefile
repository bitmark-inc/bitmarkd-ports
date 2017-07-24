# Created by: Christopher Hall <hsw@bitmark.com>
# $FreeBSD$

PORTNAME=	bitmark-wallet
PORTVERSION=	0.1
DISTVERSIONPREFIX=	v
CATEGORIES=	finance

MAINTAINER=	jim@bitmark.com
COMMENT=	Bitmark HD Wallet

LICENSE=	ISCL
LICENSE_FILE=	${WRKSRC}/LICENSE

BUILD_DEPENDS=	go:lang/go

MASTER_SITE_OVERRIDE=	https://repo.bitmark.com/gbvchnrdfttztpdfgcgftthfrbknddtzpmjfvqtxnmkcmvdqfvrfwvbjqzhgddcn/

USES=		pkgconfig
ONLY_FOR_ARCHS=	amd64 i386

USE_GITHUB=	yes
GH_ACCOUNT=	bitmark-inc:DEFAULT
GH_TUPLE=	bitmark-inc:bitmarkd:v4.10:bitmarkd/src/github.com/bitmark-inc/bitmarkd \
		bitmark-inc:logger:v3.2:logger/src/github.com/bitmark-inc/logger \
		cihub:seelog:f561c5e:seelog/src/github.com/cihub/seelog \
		NebulousLabs:entropy-mnemonics:7b01a64:entropy_mnemonics/src/github.com/NebulousLabs/entropy-mnemonics \
		boltdb:bolt:v1.3.1:bolt/src/github.com/boltdb/bolt \
		fsnotify:fsnotify:v1.4.2:fsnotify/src/github.com/fsnotify/fsnotify \
		hashicorp:hcl:392dba7:hcl/src/github.com/hashicorp/hcl \
		magiconair:properties:v1.7.3:properties/src/github.com/magiconair/properties \
		mitchellh:mapstructure:d0303fe:mapstructure/src/github.com/mitchellh/mapstructure \
		pelletier:go-toml:69d355d:go_toml/src/github.com/pelletier/go-toml \
		spf13:afero:9be6508:afero/src/github.com/spf13/afero \
		spf13:cast:acbeb36:cast/src/github.com/spf13/cast \
		spf13:cobra:b4dbd37:cobra/src/github.com/spf13/cobra \
		spf13:jWalterWeatherman:0efa520:jWalterWeatherman/src/github.com/spf13/jwalterweatherman \
		spf13:pflag:e57e3ee:pflag/src/github.com/spf13/pflag \
		spf13:viper:a1ecfa6:viper/src/github.com/spf13/viper \
		golang:crypto:850760c:crypto/src/golang.org/x/crypto \
		golang:sys:c4489fa:sys/src/golang.org/x/sys \
		golang:text:3491b61:text/src/golang.org/x/text \
		bitgoin:packer:f44a7cc:packer/src/github.com/bitgoin/packer \
		bitgoin:address:ace0060:address/src/github.com/bitgoin/address \
		bitgoin:tx:4d366f3:tx/src/github.com/bitgoin/tx \
		btcsuite:fastsha256:637e656:fastsha256/src/github.com/btcsuite/fastsha256 \
		go-yaml:yaml:v2:yaml/src/gopkg.in/yaml.v2

SHARE_FILES=	README.md
PLIST_FILES=	bin/${PORTNAME}
PLIST_FILES+=	"@sample etc/${PORTNAME}.conf.sample"

post-patch:
	@${MKDIR} ${WRKSRC}/src/github.com/${GH_ACCOUNT_DEFAULT}/${PORTNAME}
	@${MV} ${WRKSRC}/*.go ${WRKSRC}/src/github.com/${GH_ACCOUNT_DEFAULT}/${PORTNAME}
	@${MV} ${WRKSRC}/agent ${WRKSRC}/src/github.com/${GH_ACCOUNT_DEFAULT}/${PORTNAME}
	@${MV} ${WRKSRC}/command ${WRKSRC}/src/github.com/${GH_ACCOUNT_DEFAULT}/${PORTNAME}

do-build:
	cd ${WRKSRC}/src/github.com/${GH_ACCOUNT_DEFAULT}/${PORTNAME}/command/${PORTNAME} && \
	  ${SETENV} GOPATH=${WRKSRC} go 'install' --ldflags "-X main.version=${DISTVERSION}" ./...

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/bin/${PORTNAME} ${STAGEDIR}${PREFIX}/bin
	${INSTALL_DATA} ${WRKSRC}/src/github.com/bitmark-inc/${PORTNAME}/command/${PORTNAME}/wallet.conf.sample ${STAGEDIR}${PREFIX}/etc/${PORTNAME}.conf.sample

.include <bsd.port.mk>
