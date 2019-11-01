# Created by: Linzy Hu <linzy@bitmark.com>
# $FreeBSD$

PORTNAME=	discovery
PORTVERSION=	0.9.0
DISTVERSIONPREFIX=	v
PORTREVISION=	2
CATEGORIES=	net-p2p

MAINTAINER=	linzy@bitmark.com
COMMENT=	Currency proxy for bitmarkd

LICENSE=	ISCL
LICENSE_FILE=	${WRKSRC}/LICENSE

LIB_DEPENDS=	libzmq.so:net/libzmq4

USES=		pkgconfig go:modules

USE_GITHUB=	yes
GH_ACCOUNT=	bitmark-inc:DEFAULT
GH_TUPLE=	bitmark-inc:logger:v0.3.4:logger/vendor/github.com/bitmark-inc/logger \
		cihub:seelog:f561c5e57575:seelog/vendor/github.com/cihub/seelog \
		pebbe:zmq4:v1.0.0:zmq4/vendor/github.com/pebbe/zmq4 \
		hashicorp:hcl:v1.0.0:hcl/vendor/github.com/hashicorp/hcl

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

PLIST_SUB+=	DISCOVERY_USER=discovery \
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
