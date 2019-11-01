# Created by: Christopher Hall <hsw@bitmark.com>
# $FreeBSD$

PORTNAME=	bitmark-wallet
PORTVERSION=	0.6.0
DISTVERSIONPREFIX=	v
PORTREVISION=	1
CATEGORIES=	finance

MAINTAINER=	jim@bitmark.com
COMMENT=	Bitmark HD Wallet

LICENSE=	ISCL
LICENSE_FILE=	${WRKSRC}/LICENSE

USES=		pkgconfig go:modules

USE_GITHUB=	yes
GH_ACCOUNT=	bitmark-inc:DEFAULT
GH_TUPLE=	bitgoin:address:ace0060e54fd:address/vendor/github.com/bitgoin/address \
		bitgoin:packer:f44a7cc6790a:packer/vendor/github.com/bitgoin/packer \
		bitmark-inc:bitmarkd:v0.9.1:bitmarkd/vendor/github.com/bitmark-inc/bitmarkd \
		bitmark-inc:logger:v0.3.4:logger/vendor/github.com/bitmark-inc/logger \
		boltdb:bolt:v1.3.1:bolt/vendor/github.com/boltdb/bolt \
		btcsuite:fastsha256:637e65642941:fastsha256/vendor/github.com/btcsuite/fastsha256 \
		cihub:seelog:f561c5e57575:seelog/vendor/github.com/cihub/seelog \
		davecgh:go-spew:v1.1.1:go_spew/vendor/github.com/davecgh/go-spew \
		fsnotify:fsnotify:v1.4.7:fsnotify/vendor/github.com/fsnotify/fsnotify \
		hashicorp:hcl:v1.0.0:hcl/vendor/github.com/hashicorp/hcl \
		kr:pretty:v0.1.0:pretty/vendor/github.com/kr/pretty \
		kr:pty:v1.1.1:pty/vendor/github.com/kr/pty \
		kr:text:v0.1.0:text/vendor/github.com/kr/text \
		magiconair:properties:v1.8.0:properties/vendor/github.com/magiconair/properties \
		mitchellh:mapstructure:v1.1.2:mapstructure/vendor/github.com/mitchellh/mapstructure \
		NebulousLabs:entropy-mnemonics:bc7e13c5ccd8:entropy_mnemonics/vendor/github.com/NebulousLabs/entropy-mnemonics \
		pelletier:go-toml:v1.2.0:go_toml/vendor/github.com/pelletier/go-toml \
		pmezard:go-difflib:v1.0.0:go_difflib/vendor/github.com/pmezard/go-difflib \
		spf13:afero:v1.1.2:afero/vendor/github.com/spf13/afero \
		spf13:cast:v1.3.0:cast/vendor/github.com/spf13/cast \
		spf13:cobra:v0.0.3:cobra/vendor/github.com/spf13/cobra \
		spf13:jwalterweatherman:v1.0.0:jwalterweatherman/vendor/github.com/spf13/jwalterweatherman \
		spf13:pflag:v1.0.3:pflag/vendor/github.com/spf13/pflag \
		spf13:viper:v1.3.1:viper/vendor/github.com/spf13/viper \
		stretchr:testify:v1.2.2:testify/vendor/github.com/stretchr/testify \
		golang:crypto:505ab145d0a9:crypto/vendor/golang.org/x/crypto \
		golang:sys:a5c9d58dba9a:sys/vendor/golang.org/x/sys \
		golang:text:v0.3.0:text/vendor/golang.org/x/text \
		go-check:check:788fd7840127:go_check/vendor/gopkg.in/check.v1 \
		go-yaml:yaml:v2.2.2:go_yaml/vendor/gopkg.in/yaml.v2

SHARE_FILES=	README.md
PLIST_FILES=	bin/${PORTNAME}
PLIST_FILES+=	"@sample etc/${PORTNAME}.conf.sample"

GO_TARGET+=	./command/${PORTNAME}

do-install:
	${INSTALL_PROGRAM} ${WRKDIR}/bin/${PORTNAME} ${STAGEDIR}${PREFIX}/bin
	${INSTALL_DATA} ${WRKSRC}/command/${PORTNAME}/wallet.conf.sample ${STAGEDIR}${PREFIX}/etc/${PORTNAME}.conf.sample

.include <bsd.port.mk>
