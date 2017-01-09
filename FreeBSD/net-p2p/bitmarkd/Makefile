# Created by: Christopher Hall <hsw@bitmark.com>
# $FreeBSD$

PORTNAME=	bitmarkd
PORTVERSION=	3.13
DISTVERSIONPREFIX=	v
CATEGORIES=	net-p2p

MAINTAINER=	hsw@bitmark.com
COMMENT=	Bitmark distributed property daemon

LICENSE=	ISCL
LICENSE_FILE=	${WRKSRC}/LICENSE

LIB_DEPENDS=	libucl.so:textproc/libucl \
		libargon2.so:security/libargon2 \
		libzmq.so:net/libzmq4
BUILD_DEPENDS=	go:lang/go

CONFLICTS_INSTALL=	bitmarkd-1.*

USES=		pkgconfig
ONLY_FOR_ARCHS=	i386 amd64

USE_GITHUB=	yes
GH_ACCOUNT=	bitmark-inc:DEFAULT
GH_TUPLE=	bitmark-inc:certgen:c8407fd:certgen \
		bitmark-inc:exitwithstatus:1d600d0:exitwithstatus \
		bitmark-inc:getoptions:6a9c441:getoptions \
		bitmark-inc:go-argon2:c995b93:go_argon2 \
		bitmark-inc:go-libucl:6e53e8a:go_libucl \
		bitmark-inc:listener:5b92961:listener \
		bitmark-inc:logger:9cf06da:logger \
		cihub:seelog:175e6e3:seelog \
		golang:snappy:d9eb7a3:snappy \
		pebbe:zmq4:eccbb48:zmq4 \
		syndtr:goleveldb:6b4daa5:goleveldb \
		golang:crypto:5f4e837:crypto

STRIP=		# stripping can break go binaries

USERS=		bitmarkd prooferd
GROUPS=		bitmarkd prooferd
BITMARKD_RUN=	/var/run/bitmarkd
BITMARKD_DATA=	/var/lib/bitmarkd
PROOFERD_RUN=	/var/run/prooferd
PROOFERD_DATA=	/var/lib/prooferd
BINARY_COMMANDS=	bitmarkd prooferd

#PLIST_FILES=	"@sample %%ETCDIR%%/bitmarkd.conf.sample" ## if want etc/Bitmarkd/bitmarkd.conf.sample
.for command in ${BINARY_COMMANDS}
PLIST_FILES+=	"@sample etc/${command}.conf.sample"
PLIST_FILES+=	sbin/${command}
.endfor
PLIST_FILES+=	"@dir(%%BITMARKD_USER%%,%%BITMARKD_GROUP%%,) %%BITMARKD_DATA%%"
PLIST_FILES+=	"@dir(%%BITMARKD_USER%%,%%BITMARKD_GROUP%%,) %%BITMARKD_RUN%%"
PLIST_FILES+=	"@dir(%%PROOFERD_USER%%,%%PROOFERD_GROUP%%,) %%PROOFERD_DATA%%"
PLIST_FILES+=	"@dir(%%PROOFERD_USER%%,%%PROOFERD_GROUP%%,) %%PROOFERD_RUN%%"
PLIST_FILES+=	"@dir /var/lib"

USE_RC_SUBR=	bitmarkd prooferd
SUB_LIST+=	BITMARKD_USER=bitmarkd \
		BITMARKD_GROUP=bitmarkd \
		BITMARKD_RUN=${BITMARKD_RUN} \
		BITMARKD_DATA=${BITMARKD_DATA} \
		PROOFERD_USER=prooferd \
		PROOFERD_GROUP=prooferd \
		PROOFERD_RUN=${PROOFERD_RUN} \
		PROOFERD_DATA=${PROOFERD_DATA}
PLIST_SUB+=	BITMARKD_USER=bitmarkd \
		BITMARKD_GROUP=bitmarkd \
		BITMARKD_RUN=${BITMARKD_RUN} \
		BITMARKD_DATA=${BITMARKD_DATA} \
		PROOFERD_USER=prooferd \
		PROOFERD_GROUP=prooferd \
		PROOFERD_RUN=${PROOFERD_RUN} \
		PROOFERD_DATA=${PROOFERD_DATA}

BITMARKD_ITEMS=	account \
		announce \
		asset \
		avl \
		background \
		block \
		blockdigest \
		blockrecord \
		blockring \
		chain \
		command \
		configuration \
		counter \
		currency \
		debian \
		difficulty \
		fault \
		genesis \
		merkle \
		messagebus \
		mode \
		payment \
		peer \
		proof \
		reservoir \
		rpc \
		storage \
		transactionrecord \
		util \
		version \
		zmqutil

post-patch:
.for account in bitmark-inc cihub golang pebbe syndtr
	@${MKDIR} ${WRKSRC}/src/github.com/${account}
.endfor

	${MKDIR} ${WRKSRC}/src/github.com/${GH_ACCOUNT}/${PORTNAME}
.for src in ${BITMARKD_ITEMS}
	@${MV} ${WRKSRC}/${src} ${WRKSRC}/src/github.com/${GH_ACCOUNT}/${PORTNAME}
.endfor

	${MKDIR} ${WRKSRC}/src/golang.org/x

	@${MV} ${WRKSRC_certgen} ${WRKSRC}/src/github.com/bitmark-inc/certgen
	@${MV} ${WRKSRC_exitwithstatus} ${WRKSRC}/src/github.com/bitmark-inc/exitwithstatus
	@${MV} ${WRKSRC_getoptions} ${WRKSRC}/src/github.com/bitmark-inc/getoptions
	@${MV} ${WRKSRC_go_argon2} ${WRKSRC}/src/github.com/bitmark-inc/go-argon2
	@${MV} ${WRKSRC_go_libucl} ${WRKSRC}/src/github.com/bitmark-inc/go-libucl
	@${MV} ${WRKSRC_listener} ${WRKSRC}/src/github.com/bitmark-inc/listener
	@${MV} ${WRKSRC_logger} ${WRKSRC}/src/github.com/bitmark-inc/logger
	@${MV} ${WRKSRC_seelog} ${WRKSRC}/src/github.com/cihub/seelog
	@${MV} ${WRKSRC_snappy} ${WRKSRC}/src/github.com/golang/snappy
	@${MV} ${WRKSRC_zmq4} ${WRKSRC}/src/github.com/pebbe/zmq4
	@${MV} ${WRKSRC_goleveldb} ${WRKSRC}/src/github.com/syndtr/goleveldb
	@${MV} ${WRKSRC_crypto} ${WRKSRC}/src/golang.org/x/crypto

do-build:
.for command in ${BINARY_COMMANDS}
	@cd ${WRKSRC}/src/github.com/${GH_ACCOUNT}/${PORTNAME}/command/${command} && ${SETENV} GOPATH=${WRKSRC} go "install" .
.endfor

do-install:
.for command in ${BINARY_COMMANDS}
	${INSTALL_PROGRAM} ${WRKSRC}/bin/${command} ${STAGEDIR}${PREFIX}/sbin
#	${INSTALL_MAN} ${WRKSRC}/man/${command}.1 ${STAGEDIR}${MAN1PREFIX}/man/man1
	${INSTALL_DATA} ${WRKSRC}/src/github.com/bitmark-inc/bitmarkd/command/${command}/${command}.conf.sample ${STAGEDIR}${PREFIX}/etc/${command}.conf.sample
.endfor
	${MKDIR} ${STAGEDIR}${BITMARKD_RUN}
	${MKDIR} ${STAGEDIR}${BITMARKD_DATA}
	${MKDIR} ${STAGEDIR}${PROOFERD_RUN}
	${MKDIR} ${STAGEDIR}${PROOFERD_DATA}

.include <bsd.port.mk>
