# Maintainer: pdq <pdq@tormail.org>
pkgname=qdm
pkgver=0.0.1
pkgrel=1
pkgdesc="quick display manager - GIT Version"
arch=(any)
url="https://github.com/idk/qdm.git"
license=('GPL')
conflicts=('pdq')
depends=('dialog')
optdepends=('vorbis-tools: Extra tools for Ogg-Vorbis')
makedepends=('git')

_gitroot="git://github.com/idk/qdm.git"
_gitname="qdm"

#install=$pkgname.install

build() {
	cd "$srcdir"
	msg "Connecting to GIT server...."

	if [ -d $_gitname ] ; then
		cd $_gitname && git pull origin
		msg "The local files are updated."
	else
		git clone $_gitroot $_gitname
	fi

	msg "GIT checkout done or server timeout"
	msg "Starting make..."

	rm -rf "$srcdir/$_gitname-build"
	git clone "$srcdir/$_gitname" "$srcdir/$_gitname-build"
	cd "$srcdir/$_gitname-build"

	# Create pkgdir folders
	mkdir -p "$pkgdir/etc/xdg/$pkgname"
	install -Dm644 "$srcdir/$_gitname-build/*" "$pkgdir/etc/xdg/$pkgname/"

	# Install
	install -Dm755 "$srcdir/$_gitname-build/$pkgname.sh" "$pkgdir/usr/bin/$pkgname"
}
