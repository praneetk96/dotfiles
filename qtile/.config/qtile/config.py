import os
import subprocess
from libqtile import bar, hook, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
import colors

mod = "mod4"
terminal = "alacritty -e /bin/fish"
alt_terminal = "xfce4-terminal"
launcher = "rofi -show drun"
browser = "brave-browser"
alt_browser = "brave-browser --incognito"
fileManager = "thunar"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "up", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "left", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "right", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "up", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "right", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "up", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key(["control"], "Return", lazy.spawn(alt_terminal), desc="Launch terminal"),
    Key([mod], "r", lazy.spawn(launcher), desc="Launch rofi"),
    Key([mod], "b", lazy.spawn(browser), desc="Launch web browser"),
    Key([mod], "e", lazy.spawn(fileManager), desc="Launch file manager"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )

# groups = [Group(i) for i in "123456789"]
# groups = [
        # Group('1', label="一", matches=[Match(wm_class='brave-browser')], layout="monadtall"),
        # Group('2', label="二", layout="monadtall"),
        # Group('3', label="三", layout="monadtall"),
        # Group('4', label="四", matches=[Match(wm_class='soffice')], layout="monadtall"),
        # Group('5', label="五", layout="monadtall"),
        # Group('6', label="六", matches=[Match(wm_class='TelegramDesktop')], layout="monadtall"),
        # Group('7', label="七", layout="monadtall"),
        # Group('8', label="八", matches=[Match(wm_class='mpv')], layout="monadtall"),
        # Group('9', label="九", layout="monadtall"),
        # Group('0', label="十", matches=[Match(wm_class='easyeffects')], layout="monadtall"),
        # ]

groups = []
group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

# Uncomment only one of the following lines
group_labels = ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十"]
# group_labels = ["", "", "👁", "", "", "", "✀", "꩜", "", "⎙"]
# group_labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
# group_labels = ["DEV", "WWW", "SYS", "DOC", "VBOX", "CHAT", "MUS", "VID", "GFX", "MISC"]

# The default layout for each of the 10 workspaces
group_layouts = ["monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall"]

# group_matches = [
        # matches=[Match(wm_class='brave-browser')],
        # matches=[Match(wm_class='')],
        # matches=[Match(wm_class='')],
        # matches=[Match(wm_class='soffice')],
        # matches=[Match(wm_class='')],
        # matches=[Match(wm_class='TelegramDesktop')],
        # matches=[Match(wm_class='')],
        # matches=[Match(wm_class='mpv')],
        # matches=[Match(wm_class='')],
        # matches=[Match(wm_class='easyeffects')],
        # ]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
            # match=group_matches[i],
        ))

for i in groups:
    keys.extend(
        [
            # mod + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            # mod + shift + group number = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc=f"Switch to & move focused window to group {i.name}",
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod + shift + group number = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

colors = colors.Dracula

layout_theme = {"border_width": 2,
                "margin": 6,
                "border_focus": colors[8],
                "border_normal": colors[0],
                "single_border_width": 0,
                "single_margin": 0,
                }
float_theme = {
                "border_focus": colors[8],
                "border_normal": colors[0],
                "border_width": 5,
                "fullscreen_border_width": 0,
                # "max_border_width": 5,
                }

layouts = [
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Max(**layout_theme),
    layout.Floating(**float_theme)
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(),
    # layout.Columns(**layout_theme),
    # layout.Matrix(),
    # layout.RatioTile(),
    # layout.Stack(num_stacks=2),
    # layout.Tile(**layout_theme),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="Ubuntu Nerd Font Bold",
    fontsize=12,
    padding=0,
    background = colors[0],
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        # bottom=bar.Bar(
        top=bar.Bar(
            [
                widget.Spacer(length = 8),
                widget.Image(
                    filename = "~/.config/qtile/icons/python.png",
                    scale = "False",
                    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn("qtilekeys-yad")},
                    ),
                widget.Prompt(),
                widget.GroupBox(
                    fontsize = 11,
                    margin_y = 5,
                    margin_x = 14,
                    padding_y = 0,
                    padding_x = 2,
                    borderwidth = 3,
                    active = colors[8],
                    inactive = colors[9],
                    rounded = False,
                    highlight_color = colors[0],
                    highlight_method = "line",
                    this_current_screen_border = colors[7],
                    this_screen_border = colors [4],
                    other_current_screen_border = colors[7],
                    other_screen_border = colors[4],
                    ),
                # widget.TextBox(
                    # text = '|',
                    # font = "UbuntuMono Nerd Font Regular",
                    # foreground = colors[9],
                    # padding = 2,
                    # fontsize = 14
                    # ),
                # widget.LaunchBar(
                    # progs = [("🦁", "brave", "Brave web browser"),
                             # ("🚀", "alacritty", "Alacritty terminal"),
                             # ("📁", "thunar", "Thunar file manager"),
                             # ("🎸", "vlc", "VLC media player")
                             # ],
                    # fontsize = 12,
                    # padding = 12,
                    # foreground = colors[3],
                    # ),
                widget.TextBox(
                    text = '|',
                    font = "UbuntuMono Nerd Font Regular",
                    foreground = colors[9],
                    padding = 2,
                    fontsize = 14
                    ),
                widget.CurrentLayout(),
                widget.TextBox(
                    text = '|',
                    font = "UbuntuMono Nerd Font Regular",
                    foreground = colors[9],
                    padding = 2,
                    fontsize = 14
                    ),
                # widget.Spacer(),
                widget.WindowName(
                    foreground = colors[6],
                    padding = 8,
                    max_chars = 40
                    ),
                # widget.Spacer(),
                # widget.Chord(
                    # chords_colors={
                        # "launch": ("#ff0000", "#ffffff"),
                    # },
                    # name_transform=lambda name: name.upper(),
                # ),
                # widget.TextBox("default config", name="default"),
                # widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                widget.CPU(
                        foreground = colors[4],
                        padding = 8, 
                        mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(terminal + ' -e htop')},
                        format = '  Cpu: {load_percent}%',
                        ),
                widget.Memory(
                        foreground = colors[8],
                        padding = 8, 
                        mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(terminal + ' -e htop')},
                        format = '{MemUsed: .0f}{mm}',
                        fmt = '  Mem: {}',
                        ),
                widget.Volume(
                        foreground = colors[7],
                        padding = 8, 
                        # fmt = '🕫  Vol: {}',
                        fmt = '  Vol: {}',
                        ),
                widget.Clock(
                        foreground = colors[8],
                        padding = 8,
                        # format="%Y-%m-%d %a %I:%M %p",
                        ## Uncomment for date and time 
                        # format = "⧗  %a, %b %d - %I:%M %p",
                        format = "  %a, %b %d - %I:%M %p",
                        ## Uncomment for time only
                        # format = "⧗  %I:%M %p",
                        # format = "  %I:%M %p",
                        ),
                widget.Systray(padding = 6),
                widget.Spacer(length = 8),
                # widget.QuickExit(),
            ],
            24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_class="Alacritty"),  # gitk
        Match(wm_class="Arandr"),  # gitk
        Match(wm_class="Atril"),  # gitk
        Match(wm_class="Bitwarden"),  # gitk
        Match(wm_class="easyeffects"),  # gitk
        Match(wm_class="Eom"),  # gitk
        Match(wm_class="Galculator"),  # gitk
        Match(wm_class="Gedit"),  # gitk
        Match(wm_class="gnome-calculator"),  # gitk
        Match(wm_class="GParted"),  # gitk
        Match(wm_class="Grsync"),  # gitk
        Match(wm_class="Grub-customizer"),  # gitk
        Match(wm_class="mpv"),  # gitk
        Match(wm_class="nitrogen"),  # gitk
        Match(wm_class="Qalculate-gtk"),  # gitk
        Match(wm_class="TelegramDesktop"),  # gitk
        Match(wm_class="Thunar"),  # gitk
        Match(wm_class="Tk"),  # gitk
    ]
)
auto_fullscreen = True
# focus_on_window_activation = "smart"
focus_on_window_activation = "focus"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call(home)

# To keep mpv always in floating mode even when toggling fullscreen
@hook.subscribe.float_change
def float_mpv():
    window = qtile.current_window
    wm_class = window.get_wm_class()
    if wm_class and "mpv" in wm_class:
        window.floating = True
        # window.cmd_center()
        screen = window.group.screen
        x = screen.x + (screen.width - window.width) // 2
        y = screen.y + (screen.height - window.height) // 2
        window.place(
            x,
            y,
            window.width,
            window.height,
            window.borderwidth,
            window.bordercolor,
            above=True,
            respect_hints=True,
        )

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
