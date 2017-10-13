# $FreeBSD$

PORTNAME=	qwebirc
PORTVERSION=	20171006
PORTREVISION=	4
CATEGORIES=	irc www

MAINTAINER=	hsw@bitmark.com
COMMENT=	Fast, easy to use, free, and open source web IRC client

LICENSE=	GPLv2

RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}twisted>=0:devel/py-twisted \
		${PYTHON_PKGNAMEPREFIX}autobahn>=0:www/py-autobahn \
		${PYTHON_PKGNAMEPREFIX}service_identity>=0:security/py-service_identity

USES=		python:2.7
NO_BUILD=	yes
NO_ARCH=	yes
SUB_LIST+=	USERS=${WWWOWN}
SUB_LIST+=	GROUPS=${WWWGRP}
SUB_LIST+=	RUNDIR=/var/run/${PORTNAME}
SUB_LIST+=	SCRIPTDIR=${WWWDIR}

USE_GITHUB=	yes
GH_PROJECT=	qwebirc
GH_ACCOUNT=	qwebirc
GH_TAGNAME=	a6c1592

USE_RC_SUBR=	qwebirc

do-install:
	(cd ${WRKSRC} && \
		${COPYTREE_SHARE} \* ${STAGEDIR}${WWWDIR} )

post-install:
	${MV} ${STAGEDIR}${WWWDIR}/config.py.example \
		${STAGEDIR}${WWWDIR}/config.py.sample
	chown -R '${WWWOWN}:${WWWGRP}' ${STAGEDIR}${WWWDIR}

.include <bsd.port.mk>
