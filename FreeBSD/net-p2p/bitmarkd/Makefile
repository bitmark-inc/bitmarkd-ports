# Created by: Christopher Hall <hsw@bitmark.com>
# $FreeBSD$

PORTNAME=	bitmarkd
DISTVERSIONPREFIX=	v
DISTVERSION=	0.11.0-rc.3
CATEGORIES=	net-p2p

MAINTAINER=	hsw@bitmark.com
COMMENT=	Bitmark distributed property daemon

LICENSE=	ISCL
LICENSE_FILE=	${WRKSRC}/LICENSE

ONLY_FOR_ARCHS=	amd64 i386
LIB_DEPENDS=	libargon2.so:security/libargon2 \
		libzmq.so:net/libzmq4
BUILD_DEPENDS=	go:lang/go

USES=		pkgconfig go:modules

USE_GITHUB=	yes
GH_ACCOUNT=	bitmark-inc:DEFAULT
GH_TUPLE=	bitmark-inc:certgen:v0.1.1:certgen/src/github.com/bitmark-inc/certgen
GH_TUPLE+=	bitmark-inc:exitwithstatus:v0.1.2:exitwithstatus/src/github.com/bitmark-inc/exitwithstatus
GH_TUPLE+=	bitmark-inc:getoptions:v0.1.1:getoptions/src/github.com/bitmark-inc/getoptions
GH_TUPLE+=	bitmark-inc:go-argon2:v0.1.4:go_argon2/src/github.com/bitmark-inc/go-argon2
GH_TUPLE+=	bitmark-inc:listener:v0.2.0:listener/src/github.com/bitmark-inc/listener
GH_TUPLE+=	bitmark-inc:logger:v0.3.4:logger/src/github.com/bitmark-inc/logger
GH_TUPLE+=	cihub:seelog:f561c5e57575:seelog/src/github.com/cihub/seelog
GH_TUPLE+=	fsnotify:fsnotify:v1.4.7:fsnotify/src/github.com/fsnotify/fsnotify
GH_TUPLE+=	golang:crypto:4def268fd1a4:crypto/src/golang.org/x/crypto
GH_TUPLE+=	golang:snappy:v0.0.1:snappy/src/github.com/golang/snappy
GH_TUPLE+=	golang:sys:fae7ac547cb7:sys/src/golang.org/x/sys
GH_TUPLE+=	golang:time:9d24e82272b4:time/src/golang.org/x/time
GH_TUPLE+=	miekg:dns:v1.1.15:dns/src/github.com/miekg/dns
GH_TUPLE+=	mitchellh:mapstructure:v1.1.2:mapstructure/src/github.com/mitchellh/mapstructure
GH_TUPLE+=	patrickmn:go-cache:v2.1.0:go_chche/src/github.com/patrickmn/go-cache
GH_TUPLE+=	pebbe:zmq4:v1.0.0:zmq4/src/github.com/pebbe/zmq4
GH_TUPLE+=	syndtr:goleveldb:v1.0.0:goleveldb/src/github.com/syndtr/goleveldb
GH_TUPLE+=	urfave:cli:v1.20.0:cli/src/github.com/urfave/cli
GH_TUPLE+=	yuin:gluamapper:d836955830e7:gluamapper/src/github.com/yuin/gluamapper
GH_TUPLE+=	yuin:gopher-lua:1cd887cd7036:gopher_lua/src/github.com/yuin/gopher-lua

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
