project('com.github.padjis.ghistory','vala','c', version: '1.0.0')

config_data = configuration_data()
config_data.set('EXEC_NAME', meson.project_name())

i18n = import('i18n')

# Src build
message('Src build')

conf_data = configuration_data()
conf_data.set_quoted('PROJECT_NAME', meson.project_name())
conf_data.set_quoted('GETTEXT_PACKAGE', meson.project_name())
conf_data.set_quoted('VERSION', meson.project_version())
conf_data.set_quoted('PREFIX', get_option('prefix'))

gnome = import('gnome')

# Include GResource
asresources = gnome.compile_resources(
    'as-resources', join_paths('data', 'com.github.padjis.ghistory.gresource.xml'),
    source_dir: 'data',
    c_name: 'as'
)

message('Configuring desktop entry: ' + meson.project_name() + '.desktop')

executable(
    meson.project_name(),
    'src/Main.vala',
    'src/Application.vala',
    'src/widgets/HeaderBar.vala',
    'src/window/Window.vala',
    'src/util/History.vala',
    asresources,
    dependencies: [
        dependency('gtk+-3.0'),
        dependency('gio-2.0')
    ],
    install:true
)

subdir('data')
subdir('po')

meson.add_install_script('meson/post_install.py')