# $FreeBSD$

PORTNAME=	qwebirc
PORTVERSION=	20171006
CATEGORIES=	irc www

MAINTAINER=	hsw@bitmark.com
COMMENT=	Fast, easy to use, free, and open source web IRC client

LICENSE=	GPLv2

RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}twisted>=0:devel/py-twisted

USES=		python
NO_BUILD=	yes
NO_ARCH=	yes
PLIST_SUB+=	WWWOWN="${WWWOWN}"
PLIST_SUB+=	WWWGRP="${WWWGRP}"

USE_GITHUB=	yes
GH_PROJECT=	qwebirc
GH_ACCOUNT=	qwebirc
#GH_TAGNAME=	ed6e865 # stable
GH_TAGNAME=	a6c1592

do-install:
#	@${MKDIR} ${STAGEDIR}${PREFIX}/www/${PORTNAME}
	(cd ${WRKSRC} && \
		${COPYTREE_SHARE} \* ${STAGEDIR}${WWWDIR} )

post-install:
	${MV} ${STAGEDIR}${WWWDIR}/config.py.example \
		${STAGEDIR}${WWWDIR}/config.py.sample

.include <bsd.port.mk>
