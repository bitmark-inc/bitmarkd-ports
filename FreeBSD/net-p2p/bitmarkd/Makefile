# Created by: Christopher Hall <hsw@bitmark.com>
# $FreeBSD$

PORTNAME=	bitmarkd
PORTVERSION=	5.1
PORTREVISION=	2
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

USES=		pkgconfig
ONLY_FOR_ARCHS=	i386 amd64

USE_GITHUB=	yes
GH_ACCOUNT=	bitmark-inc:DEFAULT
GH_TUPLE=	bitmark-inc:certgen:v1.0:certgen/src/github.com/bitmark-inc/certgen \
		bitmark-inc:exitwithstatus:v1.1:exitwithstatus/src/github.com/bitmark-inc/exitwithstatus \
		bitmark-inc:getoptions:v1.0:getoptions/src/github.com/bitmark-inc/getoptions \
		bitmark-inc:go-argon2:v1.1:go_argon2/src/github.com/bitmark-inc/go-argon2 \
		bitmark-inc:go-libucl:v1.2:go_libucl/src/github.com/bitmark-inc/go-libucl \
		bitmark-inc:listener:v1.2:listener/src/github.com/bitmark-inc/listener \
		bitmark-inc:logger:v3.2:logger/src/github.com/bitmark-inc/logger \
		cihub:seelog:f561c5e:seelog/src/github.com/cihub/seelog \
		golang:snappy:d9eb7a3:snappy/src/github.com/golang/snappy \
		pebbe:zmq4:86a3013:zmq4/src/github.com/pebbe/zmq4 \
		syndtr:goleveldb:23851d9:goleveldb/src/github.com/syndtr/goleveldb \
		codegangsta:cli:b892ba3:cli/src/github.com/codegangsta/cli \
		golang:crypto:7c6cc32:crypto/src/golang.org/x/crypto

STRIP=		# stripping can break go binaries

USERS=		bitmarkd prooferd
GROUPS=		bitmarkd prooferd
BITMARKD_RUN=	/var/run/bitmarkd
BITMARKD_DATA=	/var/lib/bitmarkd
PROOFERD_RUN=	/var/run/prooferd
PROOFERD_DATA=	/var/lib/prooferd

SERVER_LIST=	bitmarkd prooferd
COMMAND_LIST=	bitmark-cli

#PLIST_FILES=	"@sample %%ETCDIR%%/bitmarkd.conf.sample" ## if want etc/Bitmarkd/bitmarkd.conf.sample
.for command in ${SERVER_LIST}
PLIST_FILES+=	"@sample etc/${command}.conf.sample"
PLIST_FILES+=	sbin/${command}
.endfor
.for command in ${COMMAND_LIST}
#PLIST_FILES+=	"@sample etc/${command}.conf.sample"
PLIST_FILES+=	bin/${command}
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
.for command in ${SERVER_LIST} ${COMMAND_LIST}
	@cd ${WRKSRC}/src/github.com/${GH_ACCOUNT_DEFAULT}/${PORTNAME}/command/${command} && \
	  ${SETENV} GOPATH=${WRKSRC} go 'install' --ldflags "-X main.version=${DISTVERSION}" .
.endfor

do-install:
.for command in ${SERVER_LIST}
	${INSTALL_PROGRAM} ${WRKSRC}/bin/${command} ${STAGEDIR}${PREFIX}/sbin
#	${INSTALL_MAN} ${WRKSRC}/man/${command}.1 ${STAGEDIR}${MAN1PREFIX}/man/man1
	${INSTALL_DATA} ${WRKSRC}/src/github.com/bitmark-inc/bitmarkd/command/${command}/${command}.conf.sample ${STAGEDIR}${PREFIX}/etc/${command}.conf.sample
.endfor
.for command in ${COMMAND_LIST}
	${INSTALL_PROGRAM} ${WRKSRC}/bin/${command} ${STAGEDIR}${PREFIX}/bin
#	${INSTALL_MAN} ${WRKSRC}/man/${command}.1 ${STAGEDIR}${MAN1PREFIX}/man/man1
#	${INSTALL_DATA} ${WRKSRC}/src/github.com/bitmark-inc/bitmarkd/command/${command}/${command}.conf.sample ${STAGEDIR}${PREFIX}/etc/${command}.conf.sample
.endfor
	${MKDIR} ${STAGEDIR}${BITMARKD_RUN}
	${MKDIR} ${STAGEDIR}${BITMARKD_DATA}
	${MKDIR} ${STAGEDIR}${PROOFERD_RUN}
	${MKDIR} ${STAGEDIR}${PROOFERD_DATA}

.include <bsd.port.mk>
