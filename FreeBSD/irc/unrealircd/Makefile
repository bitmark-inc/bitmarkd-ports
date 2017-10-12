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
RUNTEMPDIR=	${RUNDIR}/tmp
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
PLIST_SUB+=	TEMPDIR=${RUNTEMPDIR}
PLIST_SUB+=	CACHEDIR=${CACHEDIR}
PLIST_SUB+=	DATADIR=${DATADIR}
PLIST_SUB+=	LOGDIR=${LOGDIR}

CPPFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib
CFLAGS+=	${CPPFLAGS}
# with-tmpdir must be /tmp or configure will fail
CONFIGURE_ARGS+= \
		--with-bindir=${BINDIR} \
		--with-scriptdir=${SCRIPTDIR} \
		--with-pidfile=${RUNDIR}/ircd.pid \
		--with-confdir=${CONFIGDIR} \
		--with-modulesdir=${MODULESDIR} \
		--with-logdir=${LOGDIR} \
		--with-cachedir=${CACHEDIR} \
		--with-datadir=${DATADIR} \
		--with-docdir=${DOCDIR} \
		--with-tmpdir=/tmp \
		--with-nick-history=2000 \
		--with-sendq=3000000 \
		--with-permissions=0600 \
		--with-fd-setsize=1024 \
		--with-system-cares \
		--with-system-pcre2 \
		--with-system-tre \
		--enable-dynamic-linking

USE_RC_SUBR=	unrealircd

OPTIONS_DEFINE=	SSL PREFIXAQ REMOTE DOCS
OPTIONS_DEFAULT=	SSL
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

SSL_CONFIGURE_ENABLE=	ssl
SSL_USES=		ssl
REMOTE_LIB_DEPENDS=	libcurl.so:ftp/curl
REMOTE_CONFIGURE_ENABLE=	libcurl=${LOCALBASE}
PREFIXAQ_CONFIGURE_ENABLE=	prefixaq

# with-tmpdir is mishandled in the unrealircd configure script
# it sets both TMPDIR for conftest programs and setup.h define
# patch setup.h to correct RUNTEMPDIR value
post-configure:
	@${SED} -i '' -E 's@^(#define TMPDIR) .*$$@\1 "${RUNTEMPDIR}"@'  ${WRKSRC}/include/setup.h

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
.for doc in ${DOCS}
	${INSTALL_DATA} ${WRKSRC}/${doc} ${STAGEDIR}${DOCSDIR}
.endfor

.include <bsd.port.mk>
