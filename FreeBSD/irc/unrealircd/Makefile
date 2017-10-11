# $FreeBSD$

PORTNAME=	unrealircd
PORTVERSION=	4.0.15
CATEGORIES=	irc ipv6
MASTER_SITES=	https://www.unrealircd.org/unrealircd4/

MAINTAINER=	hsw@bitmark.com
COMMENT=	Unreal - the next generation ircd

LICENSE=	GPLv2
LICENSE_FILE=	${WRKSRC}/LICENSE

LIB_DEPENDS=	libcares.so:dns/c-ares \
		libpcre2-32.so:devel/pcre2 \
		libtre.so:textproc/libtre

BINDIR=		${PREFIX}/sbin
DOCDIR=		${PREFIX}/share/doc/${PORTNAME}
MODULESDIR=	${PREFIX}/lib/${PORTNAME}
CONFIGDIR=	${PREFIX}/etc/${PORTNAME}
SCRIPTDIR=	${PREFIX}/libexec/${PORTNAME}
RUNDIR=		/var/run/${PORTNAME}
TEMPDIR=	/var/run/${PORTNAME}/tmp
CACHEDIR=	/var/cache/${PORTNAME}
DATADIR=	/var/db/${PORTNAME}
LOGDIR=		/var/log/${PORTNAME}

HAS_CONFIGURE=	yes

MAKE_JOBS_UNSAFE=	yes

USERS=		ircd
GROUPS=		ircd
CPE_VENDOR=	unrealircd
CPE_PRODUCT=	unrealircd

USES=		pkgconfig cpe

SUB_LIST+=	CONFIGDIR=${CONFIGDIR}
SUB_LIST+=	RUNDIR=${RUNDIR}
SUB_LIST+=	SCRIPTDIR=${SCRIPTDIR}
SUB_LIST+=	DATADIR=${DATADIR}
SUB_LIST+=	CACHEDIR=${CACHEDIR}
SUB_LIST+=	USERS=${USERS}
SUB_LIST+=	GROUPS=${GROUPS}

PLIST_SUB+=	RUNDIR=${RUNDIR}
PLIST_SUB+=	TEMPDIR=${TEMPDIR}
PLIST_SUB+=	CACHEDIR=${CACHEDIR}
PLIST_SUB+=	DATADIR=${DATADIR}
PLIST_SUB+=	LOGDIR=${LOGDIR}

CPPFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib
CFLAGS+=	${CPPFLAGS}
CONFIGURE_ARGS=	--with-listen=5 \
		--with-dpath=${CONFIGDIR} \
		--with-bindir=${BINDIR} \
		--with-scriptdir=${SCRIPTDIR} \
		--with-pidfile=${RUNDIR}/ircd.pid \
		--with-confdir=${CONFIGDIR} \
		--with-modulesdir=${MODULESDIR} \
		--with-logdir=${LOGDIR} \
		--with-cachedir=${CACHEDIR} \
		--with-tmpdir=${TEMPDIR} \
		--with-datadir=${DATADIR} \
		--with-docdir=${DOCDIR} \
		--with-nick-history=2000 \
		--with-sendq=3000000 \
		--with-bufferpool=18 \
		--with-permissions=0600 \
		--with-fd-setsize=1024 \
		--with-system-cares \
		--with-system-pcre2 \
		--with-system-tre \
		--enable-dynamic-linking

USE_RC_SUBR=	unrealircd

OPTIONS_DEFINE=	HUB NOSPOOF ZIPLINKS SSL IPV6 PREFIXAQ REMOTE DOCS
OPTIONS_DEFAULT=	HUB SSL
HUB_DESC=	Configure as a hub (otherwise configure as a leaf)
NOSPOOF_DESC=	Enable anti-spoof protection
ZIPLINKS_DESC=	Enable ziplinks support
PREFIXAQ_DESC=	Enable prefixes for chanadmin and chanowner
REMOTE_DESC=	Enable remote includes

PORTDOCS=	*
DOCS=		doc/Authors \
		doc/coding-guidelines \
		doc/Donation \
		doc/RELEASE-NOTES \
		doc/tao.of.irc \
		doc/translations.txt \
		doc/technical/005.txt \
		doc/technical/base64.txt \
		doc/technical/serverprotocol.txt

MODULES=	cap chanmodes extbans snomasks usermodes

HUB_CONFIGURE_ENABLE=	hub
NOSPOOF_CONFIGURE_ENABLE=	nospoof
ZIPLINKS_CONFIGURE_ENABLE=	ziplinks
IPV6_CONFIGURE_ENABLE=	inet6
SSL_CONFIGURE_ENABLE=	ssl
SSL_USES=		ssl
REMOTE_LIB_DEPENDS=	libcurl.so:ftp/curl
REMOTE_CONFIGURE_ENABLE=	--enable-libcurl=${LOCALBASE}
PREFIXAQ_CONFIGURE_ENABLE=	prefixaq

do-install:
	${MKDIR} ${STAGEDIR}${SCRIPTDIR}
	${INSTALL_PROGRAM} ${WRKSRC}/src/ircd ${STAGEDIR}${SCRIPTDIR}/ircd
	${MKDIR} ${STAGEDIR}${MODULESDIR}
	${MKDIR} ${STAGEDIR}${CONFIGDIR} || true
	${MKDIR} ${STAGEDIR}${CONFIGDIR}/aliases || true
	${MKDIR} ${STAGEDIR}${CONFIGDIR}/help || true
	${MKDIR} ${STAGEDIR}${CONFIGDIR}/ssl || true
	${MKDIR} ${STAGEDIR}${EXAMPLESDIR}/aliases
	${MKDIR} ${STAGEDIR}${EXAMPLESDIR}/help
	${MKDIR} ${STAGEDIR}${EXAMPLESDIR}/ssl
	${MKDIR} ${STAGEDIR}${DATADIR}
	${MKDIR} ${STAGEDIR}${CACHEDIR}
	${MKDIR} ${STAGEDIR}${RUNDIR}/tmp
	${MKDIR} ${STAGEDIR}${LOGDIR}
	${TOUCH} ${STAGEDIR}${CONFIGDIR}/ircd.motd
	${TOUCH} ${STAGEDIR}${CONFIGDIR}/ircd.rules
	${INSTALL_DATA} ${WRKSRC}/doc/conf/*.conf ${STAGEDIR}${EXAMPLESDIR}
	${INSTALL_DATA} ${WRKSRC}/doc/conf/examples/example.conf ${STAGEDIR}${EXAMPLESDIR}/unrealircd.conf
	${INSTALL_DATA} ${WRKSRC}/doc/conf/aliases/*.conf ${STAGEDIR}${EXAMPLESDIR}/aliases
	${INSTALL_DATA} ${WRKSRC}/doc/conf/help/*.conf ${STAGEDIR}${EXAMPLESDIR}/help
	${INSTALL_DATA} ${WRKSRC}/doc/conf/ssl/*.crt ${STAGEDIR}${EXAMPLESDIR}/ssl
	${INSTALL} ${WRKSRC}/src/modules/*.so ${STAGEDIR}${MODULESDIR}
.for dir in ${MODULES}
	${MKDIR} ${STAGEDIR}${MODULESDIR}/${dir}
	${INSTALL} ${WRKSRC}/src/modules/${dir}/*.so ${STAGEDIR}${MODULESDIR}/${dir}
.endfor
	${MKDIR} ${STAGEDIR}${DOCSDIR}
.for file in ${DOCS}
	${INSTALL_DATA} ${WRKSRC}/${file} ${STAGEDIR}${DOCSDIR}
.endfor

.include <bsd.port.mk>
