# Created by: Christopher Hall <hsw@bitmark.com>
# $FreeBSD$

PORTNAME=	bitmarkd
PORTVERSION=	1.1
DISTVERSIONPREFIX=	v
CATEGORIES=	net-p2p

MAINTAINER=	hsw@bitmark.com
COMMENT=	Bitmark distributed property daemon

LICENSE=	ISCL
LICENSE_FILE=	${WRKSRC}/LICENSE

LIB_DEPENDS=	libucl.so:${PORTSDIR}/textproc/libucl \
		libzmq.so:${PORTSDIR}/net/libzmq4
BUILD_DEPENDS=	go:${PORTSDIR}/lang/go

USES=		pkgconfig
ONLY_FOR_ARCHS=	i386 amd64

USE_GITHUB=	yes

GH_ACCOUNT=	bitmark-inc:DEFAULT \
		agl:ed25519 \
		cihub:seelog \
		golang:snappy \
		pebbe:zmq4 \
		syndtr:goleveldb

GH_PROJECT=	ed25519:ed25519 \
		bilateralrpc:bilateralrpc \
		certgen:certgen \
		exitwithstatus:exitwithstatus \
		getoptions:getoptions \
		go-libucl:go_libucl \
		listener:listener \
		logger:logger \
		seelog:seelog \
		snappy:snappy \
		zmq4:zmq4 \
		goleveldb:goleveldb

GH_TAGNAME=	278e1ec:ed25519 \
		dee6fef:bilateralrpc \
		c8407fd:certgen \
		1d600d0:exitwithstatus \
		508de09:getoptions \
		6e53e8a:go_libucl \
		5b92961:listener \
		9cf06da:logger \
		3549fbb:seelog \
		5f1c01d:snappy \
		83e3214:zmq4 \
		ad0d8b2:goleveldb

STRIP=		# stripping can break go binaries

USERS=		bitmarkd
GROUPS=		bitmarkd
BITMARKD_RUN=	/var/run/bitmarkd
BITMARKD_DATA=	/var/lib/bitmarkd

#PLIST_FILES=	"@sample %%ETCDIR%%/bitmarkd.conf.sample" ## if want etc/Bitmarkd/bitmarkd.conf.sample
PLIST_FILES=	"@sample etc/bitmarkd.conf.sample"
PLIST_FILES+=	sbin/bitmarkd

USE_RC_SUBR=	bitmarkd
SUB_LIST+=	BITMARKD_USER=bitmarkd \
		BITMARKD_GROUP=bitmarkd \
		BITMARKD_RUN=${BITMARKD_RUN} \
		BITMARKD_DATA=${BITMARKD_DATA}

BITMARKD_ITEMS=	announce \
		background \
		block \
		certificates.go \
		chain \
		commands.go \
		configuration \
		counter \
		difficulty \
		doc.go \
		fault \
		gnomon \
		issue-generator \
		keypair.go \
		limitedset \
		main.go \
		messagebus \
		mine \
		mode \
		payment \
		peer \
		pool \
		rpc \
		stub-server.go \
		transaction \
		util \
		version.go

post-patch:
.for account in bitmark-inc agl cihub golang pebbe syndtr
	@${MKDIR} ${WRKSRC}/src/github.com/${account}
.endfor

	${MKDIR} ${WRKSRC}/src/github.com/${GH_ACCOUNT}/${PORTNAME}
.for src in ${BITMARKD_ITEMS}
	@${MV} ${WRKSRC}/${src} ${WRKSRC}/src/github.com/${GH_ACCOUNT}/${PORTNAME}
.endfor

	@${MV} ${WRKSRC_bilateralrpc} ${WRKSRC}/src/github.com/bitmark-inc/bilateralrpc
	@${MV} ${WRKSRC_certgen} ${WRKSRC}/src/github.com/bitmark-inc/certgen
	@${MV} ${WRKSRC_exitwithstatus} ${WRKSRC}/src/github.com/bitmark-inc/exitwithstatus
	@${MV} ${WRKSRC_go_libucl} ${WRKSRC}/src/github.com/bitmark-inc/go-libucl
	@${MV} ${WRKSRC_listener} ${WRKSRC}/src/github.com/bitmark-inc/listener
	@${MV} ${WRKSRC_logger} ${WRKSRC}/src/github.com/bitmark-inc/logger
	@${MV} ${WRKSRC_ed25519} ${WRKSRC}/src/github.com/agl/ed25519
	@${MV} ${WRKSRC_goleveldb} ${WRKSRC}/src/github.com/syndtr/goleveldb
	@${MV} ${WRKSRC_seelog} ${WRKSRC}/src/github.com/cihub/seelog
	@${MV} ${WRKSRC_zmq4} ${WRKSRC}/src/github.com/pebbe/zmq4
	@${MV} ${WRKSRC_golang_snappy} ${WRKSRC}/src/github.com/golang/snappy

do-build:
	@cd ${WRKSRC}/src/github.com/${GH_ACCOUNT}/${PORTNAME} && ${SETENV} GOPATH=${WRKSRC} go install .

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/bin/bitmarkd ${STAGEDIR}${PREFIX}/sbin
#	${INSTALL_MAN} ${WRKSRC}/man/bitmarkd.1 ${STAGEDIR}${MAN1PREFIX}/man/man1
	${INSTALL_DATA} ${WRKSRC}/bitmarkd.conf.sample ${STAGEDIR}${PREFIX}/etc/bitmarkd.conf.sample

.include <bsd.port.mk>
