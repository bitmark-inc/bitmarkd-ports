# Created by: Christopher Hall <hsw@bitmark.com>
# $FreeBSD$

PORTNAME=	bitmark-wallet
PORTVERSION=	0.5
PORTREVISION=	1
DISTVERSIONPREFIX=	v
CATEGORIES=	finance

MAINTAINER=	jim@bitmark.com
COMMENT=	Bitmark HD Wallet

LICENSE=	ISCL
LICENSE_FILE=	${WRKSRC}/LICENSE

ONLY_FOR_ARCHS=	amd64 i386

BUILD_DEPENDS=	go:lang/go

USES=		pkgconfig

MASTER_SITE_OVERRIDE=	https://repo.bitmark.com/gbvchnrdfttztpdfgcgftthfrbknddtzpmjfvqtxnmkcmvdqfvrfwvbjqzhgddcn/

USE_GITHUB=	yes
GH_ACCOUNT=	bitmark-inc:DEFAULT
GH_TUPLE=	bitgoin:address:ace0060:address/src/github.com/bitgoin/address \
		bitgoin:packer:f44a7cc:packer/src/github.com/bitgoin/packer \
		bitgoin:tx:4d366f3:tx/src/github.com/bitgoin/tx \
		bitmark-inc:bitmarkd:v8.3:bitmarkd/src/github.com/bitmark-inc/bitmarkd \
		bitmark-inc:logger:v3.4:logger/src/github.com/bitmark-inc/logger \
		boltdb:bolt:v1.3.1:bolt/src/github.com/boltdb/bolt \
		btcsuite:fastsha256:637e656:fastsha256/src/github.com/btcsuite/fastsha256 \
		cihub:seelog:f561c5e:seelog/src/github.com/cihub/seelog \
		fsnotify:fsnotify:ccc981b:fsnotify/src/github.com/fsnotify/fsnotify \
		golang:crypto:0c41d7a:crypto/src/golang.org/x/crypto \
		golang:sys:fa43e7b:sys/src/golang.org/x/sys \
		golang:text:6e3c4e7:text/src/golang.org/x/text \
		hashicorp:hcl:v1.0.0:hcl/src/github.com/hashicorp/hcl \
		magiconair:properties:v1.8.0:properties/src/github.com/magiconair/properties \
		mitchellh:mapstructure:v1.1.2:mapstructure/src/github.com/mitchellh/mapstructure \
		NebulousLabs:entropy-mnemonics:7b01a64:entropy_mnemonics/src/github.com/NebulousLabs/entropy-mnemonics \
		pelletier:go-toml:c2dbbc2:go_toml/src/github.com/pelletier/go-toml \
		spf13:afero:v1.1.2:afero/src/github.com/spf13/afero \
		spf13:cast:v1.2.0:cast/src/github.com/spf13/cast \
		spf13:cobra:99dc123:cobra/src/github.com/spf13/cobra \
		spf13:jwalterweatherman:103a6da:jwalterweatherman/src/github.com/spf13/jwalterweatherman \
		spf13:pflag:v1.0.3:pflag/src/github.com/spf13/pflag \
		spf13:viper:62edee3:viper/src/github.com/spf13/viper
GH_TUPLE+=	go-yaml:yaml:v2:yaml/src/gopkg.in/yaml.v2

SHARE_FILES=	README.md
PLIST_FILES=	bin/${PORTNAME}
PLIST_FILES+=	"@sample etc/${PORTNAME}.conf.sample"

post-patch:
	@${MKDIR} ${WRKSRC}/src/github.com/${GH_ACCOUNT_DEFAULT}/${PORTNAME}
	@for f in ${WRKSRC}/*; \
	 do \
	   bn=$$(basename "$${f}") ; \
	   [ X"$${bn}" = X"src" ] && continue ; \
	   [ X"$${bn}" = X"LICENSE" ] && continue ; \
	   ${MV} "$${f}" "${WRKSRC}/src/github.com/${GH_ACCOUNT_DEFAULT}/${PORTNAME}/" ; \
	 done

do-build:
	cd ${WRKSRC}/src/github.com/${GH_ACCOUNT_DEFAULT}/${PORTNAME}/command/${PORTNAME} && \
	  ${SETENV} GOPATH=${WRKSRC} go 'install' --ldflags "-X main.version=${DISTVERSION}" ./...

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/bin/${PORTNAME} ${STAGEDIR}${PREFIX}/bin
	${INSTALL_DATA} ${WRKSRC}/src/github.com/bitmark-inc/${PORTNAME}/command/${PORTNAME}/wallet.conf.sample ${STAGEDIR}${PREFIX}/etc/${PORTNAME}.conf.sample

.include <bsd.port.mk>
