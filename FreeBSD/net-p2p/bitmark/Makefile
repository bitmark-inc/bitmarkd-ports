# $FreeBSD$

PORTNAME=	bitmark
PORTVERSION=	0.11.1
DISTVERSIONPREFIX=	v
CATEGORIES=	net-p2p

MAINTAINER=	hsw@bitmark.com
COMMENT?=	Bitmark distributed property system programs

LICENSE=	ISCL
LICENSE_FILE=	${WRKSRC}/LICENSE

ONLY_FOR_ARCHS=	amd64 armv6 armv7 i386
ONLY_FOR_ARCHS_REASON=	depends on go which is not supported in this architecture

LIB_DEPENDS=	libargon2.so:security/libargon2
LIB_DEPENDS+=	libzmq.so:net/libzmq4

CONFLICTS?=	bitmark-{daemon,cli,recorder,dumper}
SLAVE_PORT?=    no

USES=		pkgconfig go:modules

OPTIONS_DEFINE?=	DAEMON CLI DUMPER RECORDER
OPTIONS_DEFAULT?=	DAEMON CLI RECORDER
OPTIONS_SUB=		yes

DAEMON_DESC=	Main bitmarkd node server
CLI_DESC=	Command line program to access bitmarks
DUMPER_DESC=	Utility to dump bitmarkd levelDB
RECORDER_DESC=	Hashing program

.include <bsd.port.options.mk>

USE_GITHUB=	yes
GH_ACCOUNT=	bitmark-inc:DEFAULT
GH_PROJECT=	bitmarkd
GH_TUPLE=	bitmark-inc:certgen:v0.1.1:certgen/vendor/github.com/bitmark-inc/certgen
GH_TUPLE+=	bitmark-inc:exitwithstatus:v0.1.2:exitwithstatus/vendor/github.com/bitmark-inc/exitwithstatus
GH_TUPLE+=	bitmark-inc:getoptions:v0.1.1:getoptions/vendor/github.com/bitmark-inc/getoptions
GH_TUPLE+=	bitmark-inc:go-argon2:v0.1.4:go_argon2/vendor/github.com/bitmark-inc/go-argon2
GH_TUPLE+=	bitmark-inc:listener:v0.2.0:listener/vendor/github.com/bitmark-inc/listener
GH_TUPLE+=	bitmark-inc:logger:v0.3.4:logger/vendor/github.com/bitmark-inc/logger
GH_TUPLE+=	cihub:seelog:f561c5e57575:seelog/vendor/github.com/cihub/seelog
GH_TUPLE+=	fsnotify:fsnotify:v1.4.7:fsnotify/vendor/github.com/fsnotify/fsnotify
GH_TUPLE+=	golang:crypto:4def268fd1a4:crypto/vendor/golang.org/x/crypto
GH_TUPLE+=	golang:net:ba9fcec4b297:net/vendor/golang.org/x/net
GH_TUPLE+=	golang:snappy:v0.0.1:snappy/vendor/github.com/golang/snappy
GH_TUPLE+=	golang:sys:749cb33beabd:sys/vendor/golang.org/x/sys
GH_TUPLE+=	golang:time:9d24e82272b4:time/vendor/golang.org/x/time
GH_TUPLE+=	miekg:dns:v1.1.16:dns/vendor/github.com/miekg/dns
GH_TUPLE+=	mitchellh:mapstructure:v1.1.2:mapstructure/vendor/github.com/mitchellh/mapstructure
GH_TUPLE+=	patrickmn:go-cache:v2.1.0:go_chche/vendor/github.com/patrickmn/go-cache
GH_TUPLE+=	pebbe:zmq4:v1.0.0:zmq4/vendor/github.com/pebbe/zmq4
GH_TUPLE+=	syndtr:goleveldb:v1.0.0:goleveldb/vendor/github.com/syndtr/goleveldb
GH_TUPLE+=	urfave:cli:v1.21.0:cli/vendor/github.com/urfave/cli
GH_TUPLE+=	yuin:gluamapper:d836955830e7:gluamapper/vendor/github.com/yuin/gluamapper
GH_TUPLE+=	yuin:gopher-lua:1cd887cd7036:gopher_lua/vendor/github.com/yuin/gopher-lua

STRIP=		# stripping can break go binaries

SLAVE_PORT?=	NO

VAR_DIR=	/var

.if ${PORT_OPTIONS:MDAEMON}
USERS+=		bitmark
GROUPS+=	bitmark
BITMARKD_RUN=	${VAR_DIR}/run/bitmarkd
BITMARKD_DATA=	${VAR_DIR}/lib/bitmarkd
SERVER_LIST+=	bitmarkd
USE_RC_SUBR+=	bitmarkd
SUB_LIST+=	BITMARKD_USER=bitmarkd \
		BITMARKD_GROUP=bitmarkd \
		BITMARKD_RUN=${BITMARKD_RUN} \
		BITMARKD_DATA=${BITMARKD_DATA}
.endif

.if ${PORT_OPTIONS:MRECORDER}
USERS+=		bitmark-recorder
GROUPS+=	bitmark-recorder
RECORDERD_RUN=	${VAR_DIR}/run/recorderd
RECORDERD_DATA=	${VAR_DIR}/lib/recorderd
SERVER_LIST+=	recorderd
USE_RC_SUBR+=	recorderd
SUB_LIST+=	RECORDERD_USER=recorderd \
		RECORDERD_GROUP=recorderd \
		RECORDERD_RUN=${RECORDERD_RUN} \
		RECORDERD_DATA=${RECORDERD_DATA}
.endif

.if ${PORT_OPTIONS:MCLI}
COMMAND_LIST+=	bitmark-cli
.endif
.if ${PORT_OPTIONS:MDUMPER}
COMMAND_LIST+=	bitmark-dumpdb
.endif

#PLIST_FILES=	"@sample %%ETCDIR%%/bitmarkd.conf.sample" ## if want etc/Bitmarkd/bitmarkd.conf.sample
.for command in ${SERVER_LIST}
PLIST_FILES+=	"@sample etc/${command}.conf.sample"
PLIST_FILES+=	sbin/${command}
.endfor
.for command in ${COMMAND_LIST}
#PLIST_FILES+=	"@sample etc/${command}.conf.sample"
PLIST_FILES+=	bin/${command}
.endfor
.if ${PORT_OPTIONS:MDAEMON}
PLIST_FILES+=	"@dir(bitmarkd,bitmarkd,) ${BITMARKD_DATA}"
PLIST_FILES+=	"@dir(bitmarkd,bitmarkd,) ${BITMARKD_RUN}"
.endif
.if ${PORT_OPTIONS:MRECORDER}
PLIST_FILES+=	"@dir(recorderd,recorderd,) ${RECORDERD_DATA}"
PLIST_FILES+=	"@dir(recorderd,recorderd,) ${RECORDERD_RUN}"
PLIST_FILES+=	"@dir ${VAR_DIR}/lib"
.endif

GO_BUILDFLAGS+=	--ldflags "-X main.version=${DISTVERSION}"

.for command in ${SERVER_LIST} ${COMMAND_LIST}
GO_TARGET+=	./command/${command}
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
.if ${PORT_OPTIONS:MDAEMON}
	${MKDIR} ${STAGEDIR}${BITMARKD_RUN}
	${MKDIR} ${STAGEDIR}${BITMARKD_DATA}
.endif
.if ${PORT_OPTIONS:MRECORDER}
	${MKDIR} ${STAGEDIR}${RECORDERD_RUN}
	${MKDIR} ${STAGEDIR}${RECORDERD_DATA}
.endif

.include <bsd.port.mk>
