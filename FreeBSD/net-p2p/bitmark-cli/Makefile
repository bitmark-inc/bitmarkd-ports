# Created by: Christopher Hall <hsw@bitmark.com>
# $FreeBSD$

PORTNAME=	bitmark-cli
PORTVERSION=	3.1
DISTVERSIONPREFIX=	v
CATEGORIES=	net-p2p

MAINTAINER=	hsw@bitmark.com
COMMENT=	Bitmark distributed property client

LICENSE=	ISCL
LICENSE_FILE=	${WRKSRC}/LICENSE

LIB_DEPENDS=	libucl.so:textproc/libucl \
		libargon2.so:security/libargon2 \
		libzmq.so:net/libzmq4
BUILD_DEPENDS=	go:lang/go

USES=		pkgconfig
ONLY_FOR_ARCHS=	i386 amd64

USE_GITHUB=	yes
GH_ACCOUNT=	bitmark-inc:DEFAULT
GH_TUPLE=	bitmark-inc:bitmarkd:v3.0:bitmarkd \
		bitmark-inc:exitwithstatus:1d600d0:exitwithstatus \
		bitmark-inc:go-argon2:c995b93:go_argon2 \
		bitmark-inc:go-libucl:6e53e8a:go_libucl \
		bitmark-inc:logger:9cf06da:logger \
		cihub:seelog:752ef64:seelog \
		codegangsta:cli:55f715e:cli \
		golang:snappy:d9eb7a3:snappy \
		pebbe:zmq4:eccbb48:zmq4 \
		syndtr:goleveldb:8d31aaf:goleveldb \
		golang:crypto:d172538:crypto

STRIP=		# stripping can break go binaries

PLIST_FILES+=	bin/bitmark-cli

BITMARK_CLI_ITEMS=	\
		configuration \
		fault \
		templates \
		check_commands.go \
		doc.go \
		issue.go \
		issue_test.go \
		keypair.go \
		keypair_test.go \
		main.go \
		proof.go \
		version.go

post-patch:
.for account in bitmark-inc cihub codegangsta golang pebbe syndtr
	@${MKDIR} ${WRKSRC}/src/github.com/${account}
.endfor

	${MKDIR} ${WRKSRC}/src/github.com/${GH_ACCOUNT}/${PORTNAME}
.for src in ${BITMARK_CLI_ITEMS}
	@${MV} ${WRKSRC}/${src} ${WRKSRC}/src/github.com/${GH_ACCOUNT}/${PORTNAME}
.endfor

	${MKDIR} ${WRKSRC}/src/golang.org/x

	@${MV} ${WRKSRC_bitmarkd} ${WRKSRC}/src/github.com/bitmark-inc/bitmarkd
	@${MV} ${WRKSRC_exitwithstatus} ${WRKSRC}/src/github.com/bitmark-inc/exitwithstatus
	@${MV} ${WRKSRC_go_argon2} ${WRKSRC}/src/github.com/bitmark-inc/go-argon2
	@${MV} ${WRKSRC_go_libucl} ${WRKSRC}/src/github.com/bitmark-inc/go-libucl
	@${MV} ${WRKSRC_logger} ${WRKSRC}/src/github.com/bitmark-inc/logger
	@${MV} ${WRKSRC_seelog} ${WRKSRC}/src/github.com/cihub/seelog
	@${MV} ${WRKSRC_cli} ${WRKSRC}/src/github.com/codegangsta/cli
	@${MV} ${WRKSRC_snappy} ${WRKSRC}/src/github.com/golang/snappy
	@${MV} ${WRKSRC_zmq4} ${WRKSRC}/src/github.com/pebbe/zmq4
	@${MV} ${WRKSRC_goleveldb} ${WRKSRC}/src/github.com/syndtr/goleveldb
	@${MV} ${WRKSRC_crypto} ${WRKSRC}/src/golang.org/x/crypto

do-build:
	@cd ${WRKSRC}/src/github.com/${GH_ACCOUNT}/${PORTNAME} && ${SETENV} GOPATH=${WRKSRC} go "install" .

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/bin/bitmark-cli ${STAGEDIR}${PREFIX}/bin
#	${INSTALL_MAN} ${WRKSRC}/man/bitmark-cli.1 ${STAGEDIR}${MAN1PREFIX}/man/man1
#	${INSTALL_DATA} ${WRKSRC}/src/github.com/bitmark-inc/bitmark-cli/bitmark-cli.conf.sample ${STAGEDIR}${PREFIX}/etc/bitmark-cli.conf.sample

.include <bsd.port.mk>
