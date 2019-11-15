# Created by: Linzy Hu <linzy@bitmark.com>
# $FreeBSD$

PORTNAME=	discovery
DISTVERSIONPREFIX=	v
DISTVERSION=	0.10.0
CATEGORIES=	net-p2p

MAINTAINER=	linzy@bitmark.com
COMMENT=	Currency proxy for bitmarkd

LICENSE=	ISCL
LICENSE_FILE=	${WRKSRC}/LICENSE

LIB_DEPENDS=	libzmq.so:net/libzmq4

USES=		pkgconfig go:modules

USE_GITHUB=	yes
GH_ACCOUNT=	bitmark-inc:DEFAULT
GH_TUPLE=	\
		bitmark-inc:bitmarkd:v0.12.2:bitmark_inc_bitmarkd/vendor/github.com/bitmark-inc/bitmarkd \
		bitmark-inc:logger:v0.3.4:bitmark_inc_logger/vendor/github.com/bitmark-inc/logger \
		cihub:seelog:f561c5e57575:cihub_seelog/vendor/github.com/cihub/seelog \
		mitchellh:mapstructure:v1.1.2:mitchellh_mapstructure/vendor/github.com/mitchellh/mapstructure \
		pebbe:zmq4:v1.0.0:pebbe_zmq4/vendor/github.com/pebbe/zmq4 \
		yuin:gluamapper:d836955830e7:yuin_gluamapper/vendor/github.com/yuin/gluamapper \
		yuin:gopher-lua:8bfc7677f583:yuin_gopher_lua/vendor/github.com/yuin/gopher-lua

USERS=		discovery
GROUPS=		discovery
VAR_DIR=	/var
DISCOVERY_DATA=	${VAR_DIR}/lib/discovery
DISCOVERY_RUN=	${VAR_DIR}/run/discovery

USE_RC_SUBR=	discovery
SUB_LIST+=	DISCOVERY_USER=discovery \
		DISCOVERY_GROUP=discovery \
		DISCOVERY_DATA=${DISCOVERY_DATA} \
		DISCOVERY_RUN=${DISCOVERY_RUN}

PLIST_FILES+=	sbin/${PORTNAME}
PLIST_FILES+=	"@sample etc/${PORTNAME}.conf.sample"
PLIST_FILES+=	"@dir(discovery,discovery,) ${DISCOVERY_DATA}"
PLIST_FILES+=	"@dir(discovery,discovery,) ${DISCOVERY_RUN}"
PLIST_FILES+=	"@dir ${VAR_DIR}/lib"

do-install:
	${INSTALL_PROGRAM} ${WRKDIR}/bin/${PORTNAME} ${STAGEDIR}${PREFIX}/sbin
#	${INSTALL_MAN} ${WRKSRC}/man/${PORTNAME}.1 ${STAGEDIR}${MAN1PREFIX}/man/man1
	${INSTALL_DATA} ${WRKSRC}/${PORTNAME}.conf.sample ${STAGEDIR}${PREFIX}/etc/${PORTNAME}.conf.sample
	${MKDIR} ${STAGEDIR}${DISCOVERY_DATA}
	${MKDIR} ${STAGEDIR}${DISCOVERY_RUN}

.include <bsd.port.mk>
