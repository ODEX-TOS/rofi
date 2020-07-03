# Maintainer: Orestis Floros <orestisf1993@gmail.com>
# Maintainer: Dan Beste <dan.ray.beste@gmail.com>
# Maintainer: Tom Meyers <tom@odex.be>
# Contributor: Benjamin Chrétien <chretien+aur [at] lirmm [dot] fr>
# Contributor: Eric Engestrom <aur [at] engestrom [dot] ch>
# Contributor: Rasi <rasi@xssn.at>
# Contributor: Sean Pringle <sean.pringle@gmail.com>
# Contributor: SanskritFritz (gmail)


pkgname=rofi-tos
pkgver=r3177.50692bd9
pkgrel=1
pkgdesc='A window switcher, run dialog and dmenu replacement'
arch=('x86_64')
url='https://github.com/DaveDavenport/rofi/'
license=('MIT')
depends=(
  'cairo' 'flex' 'freetype2' 'libjpeg' 'librsvg' 'libx11' 'libxcb'
  'libxdg-basedir' 'libxft-bgra' 'libxkbcommon' 'libxkbcommon-x11' 'pango'
  'startup-notification' 'xcb-util' 'xcb-util-wm' 'xcb-util-xrm' 'ttf-font-awesome'
)
makedepends=('git' 'meson' 'ninja')
checkdepends=('check')
provides=("${pkgname/-tos}")
conflicts=("${pkgname/-git}" "${pkgname}")
source=(
  'git+https://github.com/ODEX-TOS/rofi#branch=next'
  'git+https://github.com/sardemff7/libgwater'
  'git+https://github.com/sardemff7/libnkutils'
)
sha256sums=('SKIP' 'SKIP' 'SKIP')

pkgver() {
  cd "${pkgname/-tos}"
  printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

prepare() {
  cd "${pkgname/-tos}"
  for module in libgwater libnkutils; do
    local submodule="subprojects/${module}"
    git submodule init "${submodule}"
    git config "submodule.${submodule}.url" "${srcdir}/${module}"
    git submodule update "${submodule}"
  done
  cd "${srcdir}"

  meson setup "${pkgname/-tos}" build \
    --buildtype release               \
    --prefix /usr
}

build() {
  ninja -C build
}

check() {
  ninja -C build test
}

package() {
  DESTDIR="${pkgdir}" ninja -C build install

  cd "${pkgname/-tos}"
  install -Dm644 COPYING "${pkgdir}/usr/share/licenses/rofi/COPYING"
  install -Dm755 Examples/*.sh -t "${pkgdir}/usr/share/doc/rofi/examples"
}

# vim: ts=2 sw=2 et:
