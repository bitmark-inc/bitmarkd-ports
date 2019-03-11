# Created by: Linzy Hu <linzy@bitmark.com>
# $FreeBSD$

PORTNAME=	discovery
PORTVERSION=	0.9.0
DISTVERSIONPREFIX=	v
CATEGORIES=	net-p2p

MAINTAINER=	linzy@bitmark.com
COMMENT=	Currency proxy for bitmarkd

LICENSE=	ISCL
LICENSE_FILE=	${WRKSRC}/LICENSE

LIB_DEPENDS=	libzmq.so:net/libzmq4
BUILD_DEPENDS=	go:lang/go

USES=		pkgconfig

USE_GITHUB=	yes
GH_ACCOUNT=	bitmark-inc:DEFAULT
GH_TUPLE=	bitmark-inc:logger:v3.3:logger/src/github.com/bitmark-inc/logger \
		cihub:seelog:f561c5e:seelog/src/github.com/cihub/seelog \
		pebbe:zmq4:90d69e4:zmq4/src/github.com/pebbe/zmq4 \
		hashicorp:hcl:392dba7:hcl/src/github.com/hashicorp/hcl

USERS=	discovery
GROUPS=	discovery
VAR_DIR=	/var
DISCOVERY_DATA=	${VAR_DIR}/lib/discovery
DISCOVERY_RUN=	${VAR_DIR}/run/discovery

USE_RC_SUBR=discovery
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
PLIST_FILES+=	"@dir /var/lib"

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
	@cd ${WRKSRC}/src/github.com/${GH_ACCOUNT_DEFAULT}/${PORTNAME} && \
	  ${SETENV} GOPATH=${WRKSRC} go 'install' --ldflags "-X main.version=${DISTVERSION}" .

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/bin/${PORTNAME} ${STAGEDIR}${PREFIX}/sbin
#	${INSTALL_MAN} ${WRKSRC}/man/${PORTNAME}.1 ${STAGEDIR}${MAN1PREFIX}/man/man1
	${INSTALL_DATA} ${WRKSRC}/src/github.com/bitmark-inc/${PORTNAME}/${PORTNAME}.conf.sample ${STAGEDIR}${PREFIX}/etc/${PORTNAME}.conf.sample
	${MKDIR} ${STAGEDIR}${DISCOVERY_DATA}
	${MKDIR} ${STAGEDIR}${DISCOVERY_RUN}

.include <bsd.port.mk>
