# Created by: Christopher Hall <hsw@bitmark.com>
# $FreeBSD$

PORTNAME=	bitmarkd
DISTVERSIONPREFIX=	v
DISTVERSION=	8.0beta2
CATEGORIES=	net-p2p

MAINTAINER=	hsw@bitmark.com
COMMENT=	Bitmark distributed property daemon

LICENSE=	ISCL
LICENSE_FILE=	${WRKSRC}/LICENSE

ONLY_FOR_ARCHS=	amd64 i386
LIB_DEPENDS=	libucl.so:textproc/libucl \
		libargon2.so:security/libargon2 \
		libzmq.so:net/libzmq4
BUILD_DEPENDS=	go:lang/go

USES=		pkgconfig

USE_GITHUB=	yes
GH_ACCOUNT=	bitmark-inc:DEFAULT
GH_TUPLE=	bitmark-inc:certgen:v1.0:certgen/src/github.com/bitmark-inc/certgen \
		bitmark-inc:exitwithstatus:v1.1:exitwithstatus/src/github.com/bitmark-inc/exitwithstatus \
		bitmark-inc:getoptions:v1.0:getoptions/src/github.com/bitmark-inc/getoptions \
		bitmark-inc:go-argon2:v1.2:go_argon2/src/github.com/bitmark-inc/go-argon2 \
		bitmark-inc:go-libucl:v1.2:go_libucl/src/github.com/bitmark-inc/go-libucl \
		bitmark-inc:listener:v1.2:listener/src/github.com/bitmark-inc/listener \
		bitmark-inc:logger:v3.3:logger/src/github.com/bitmark-inc/logger \
		cihub:seelog:f561c5e:seelog/src/github.com/cihub/seelog \
		urfave:cli:75104e9:cli/src/github.com/urfave/cli \
		golang:snappy:553a641:snappy/src/github.com/golang/snappy \
		pebbe:zmq4:230ecd8:zmq4/src/github.com/pebbe/zmq4 \
		syndtr:goleveldb:34011bf:goleveldb/src/github.com/syndtr/goleveldb \
		golang:crypto:0fcca48:crypto/src/golang.org/x/crypto \
		golang:sys:1792d66:sys/src/golang.org/x/sys

STRIP=		# stripping can break go binaries

USERS=		bitmarkd recorderd
GROUPS=		bitmarkd recorderd
VAR_DIR=	/var
BITMARKD_RUN=	${VAR_DIR}/run/bitmarkd
BITMARKD_DATA=	${VAR_DIR}/lib/bitmarkd
RECORDERD_RUN=	${VAR_DIR}/run/recorderd
RECORDERD_DATA=	${VAR_DIR}/lib/recorderd

SERVER_LIST=	bitmarkd recorderd
COMMAND_LIST=	bitmark-cli bitmark-dumpdb

#PLIST_FILES=	"@sample %%ETCDIR%%/bitmarkd.conf.sample" ## if want etc/Bitmarkd/bitmarkd.conf.sample
.for command in ${SERVER_LIST}
PLIST_FILES+=	"@sample etc/${command}.conf.sample"
PLIST_FILES+=	sbin/${command}
.endfor
.for command in ${COMMAND_LIST}
#PLIST_FILES+=	"@sample etc/${command}.conf.sample"
PLIST_FILES+=	bin/${command}
.endfor
PLIST_FILES+=	"@dir(bitmarkd,bitmarkd,) ${BITMARKD_DATA}"
PLIST_FILES+=	"@dir(bitmarkd,bitmarkd,) ${BITMARKD_RUN}"
PLIST_FILES+=	"@dir(recorderd,recorderd,) ${RECORDERD_DATA}"
PLIST_FILES+=	"@dir(recorderd,recorderd,) ${RECORDERD_RUN}"
PLIST_FILES+=	"@dir ${VAR_DIR}/lib"

USE_RC_SUBR=	bitmarkd recorderd
SUB_LIST+=	BITMARKD_USER=bitmarkd \
		BITMARKD_GROUP=bitmarkd \
		BITMARKD_RUN=${BITMARKD_RUN} \
		BITMARKD_DATA=${BITMARKD_DATA} \
		RECORDERD_USER=recorderd \
		RECORDERD_GROUP=recorderd \
		RECORDERD_RUN=${RECORDERD_RUN} \
		RECORDERD_DATA=${RECORDERD_DATA}
PLIST_SUB+=	BITMARKD_USER=bitmarkd \
		BITMARKD_GROUP=bitmarkd \
		BITMARKD_RUN=${BITMARKD_RUN} \
		BITMARKD_DATA=${BITMARKD_DATA} \
		RECORDERD_USER=recorderd \
		RECORDERD_GROUP=recorderd \
		RECORDERD_RUN=${RECORDERD_RUN} \
		RECORDERD_DATA=${RECORDERD_DATA}

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
	${MKDIR} ${STAGEDIR}${RECORDERD_RUN}
	${MKDIR} ${STAGEDIR}${RECORDERD_DATA}

.include <bsd.port.mk>
