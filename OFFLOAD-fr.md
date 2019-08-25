# Introduction
Depuis la version beta 435.17, les pilotes nvidia proposent la prise en charge de Prime par la technologie Offload. C'est un technologie de test qui ne fonctionne qu'avec une version patchée de Xorg. Cependant et après quelques exercices sur une machine test, il apparaît que la configuration de xorg pour la prise en charge de cette technique fonctionne sans soucis particulier même si elle n'offre pas l'Offload par le GPU Nvidia.

La machine test est ancienne et ne fonctionne qu'avec le pilote 390.129 dernièrement mis à jour et est donc incapable de prendre en charge l'Offload de la manière souhaitée.


Il manque encore des informations utiles pour l'exécution réelle de l'OFFLOAD, les tests ci-dessous peuvent tout simplement ne pas fonctionner.

Nous continuerons l'édition de ce document au fur et à mesure des progrès obtenus.

## Fichier xorg testé
Si vous souhaitez tester par vous même cette nouvelle fonctionnalité, voici le fichier xorg avec lequel les tests ont été fait.

### xorg.intel.conf
```
Section "Files" # <- cette partie est optionnelle et peut être retirée en toute sécurité
    ModulePath	"/usr/lib64/xorg/modules"
    ModulePath	"/opt/nvidia/xorg/modules"
EndSection

Section "ServerLayout"
	Identifier	"layout"
	Screen	0	"intel_screen"
	Option		"AllowNVIDIAGPUScreens"
EndSection

Section "Module"
	Load		"glamoregl"
EndSection

## nvidia xorg connf
Section "Device"
	Identifier	"nvidia"
	Driver		"nvidia"
	BusID		"PCI:1:0:0"
EndSection

Section "Screen"
	Identifier	"nvidia_screen"
	Device	"nvidia"
EndSection

## intel xorg conf
Section "Device"
	Identifier	"intel"
	Driver		"modesetting"
	BusID		"PCI:0:2:0"
EndSection

Section "Screen"
	Identifier	"intel_screen"
	Device	"intel"
EndSection
```

La section "Files" est ajout qui n'est pas obligatoire si vous ne faite qu'un test de compatibilité du fichier xorg sur une machine qui de toute manière ne ce sera pas capable de prendre en charge l'Offload. Ce dernier, pouvant devenir le fichier xorg par intel défaut de nvidia-prime-select pour l'utilisation de la carte intégrée Intel.

N'oubliez pas de changer les lignes BusID par vos identifiants PCI qui sont déjà enregistrés dans le fichier ```/etc/nvidia-prime/xorg.intel.conf```.


L'utilisation de DRI3 par la puce Intel est obligatoire. Il ne doit pas cependant être défini dans la configuration Xorg, l'usage du pilote 'modesetting' ne comprenant apparemment pas les options dédiées au pilote Intel. Notez aussi que la plupart des options du pilote nvidia ne sont pas non plus reconnues. Les sections "Screen" doivent donc restées vierges de toutes options.


# Test sur machine capable d'utiliser le pilote beta 435.17.
IMPORTANT: Faites une sauvegrade complète du dossier /etc/nvidia-prime avant de faire quoi que ce soit !


Cette section implique que vous avez déjà un connaissance suffisement avancée de l'arborescence GNU Linux et des divers lignes de commandes nécessaires à la copie et au déplacement de fichier et de dossiers.

Je vous conseille fortement d'installer et d'utiliser Midnight Commander (mc) pour vos opérations sous terminal. Il sera d'un usage beaucoup plus simple et vous évitera d'innombrable ligne de commande.

## Basiques et attention
Comme déjà noté, l'Offload n'est pris en charge que par le pilote beta 435.17 et une version patchée de Xorg.

Cette version se trouve sur la branche principale Xorg sur GitHub. Seule la version Ubuntau PPA de cette version test de Xorg est fournie par le [README](https://download.nvidia.com/XFree86/Linux-x86_64/435.17/README/primerenderoffload.html) de Nvidia, mais on peut supposer que les branches 'testing' de dépots des autres distributions l'ont aussi incluse (à contrôler avant de faire quoique ce soit). Vous devez donc activer les dépots "testing" de votre distribution et installer les paquets Xorg.


Attention: l'installation des paquets Xorg peut entrainer un sérieuse mis à jour de nombreux autres paquets dépendants et il peut après coup se passer de drôles de choses. Soyez prudent.


Par rapport au fichier d'origine par nvidia-prime-select, les lignes "Files" de la configuration ci-dessus ont été inversées de manière à ce que les modules xorg de la distribution soit d'abord pris en charge. Le test avec l'ordre initial ayant échoué mon laptop étant out of date.

Il est possible pour le test de devoir réinverser l'ordre, cependant, faisont les choses pas à pas.

## Test
Une fois tous les paquets installés et le fichier xorg configuré, vous pouvez redémarrer votre machine.


TRÈS IMPORTANT : Si quelque choses se passe mal et que le serveur X ne démarre pas, passez en mode console [ctrl+alt+F'x'] (de F2 à F6), entrez vos identifiants 'root' ou 'user' en administrateur, et restaurez /etc/nvidia-prime à son état d'origine. le serveur X devrait redémarrer normalement.

# Premiers tests opérationnels
L'Offload permet pour le moment l'utilisation de GLX OpenGL et de vulkan. EGL n'est pas encore pris en charge.

Si tout s'est bien passé, votre serveur X a démarré et votre session manager à ouvert votre interface favorite.

La première choses à faire depuis votre interface à partir d'un terminal est d'entrer la ligne de commande 'xrandr' suivante :

```xrandr --listproviders```

Si la version testing de xorg est patchée le terminal devrait retourner une list avec le fournisseur "NVIDIA-G0". dans ce cas vous pouvez procéder à l'étape suivante.


### Controler le fournisseur OpenGL / vulkan :

```__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia glxinfo | grep vendor```

Ceci doit retourner le vendeur NVIDIA.

### Test de Vulkan :

la librairie GLVND doit être active pour le pilote NVIDIA et le librairie VULKAN correctement installées.

```__NV_PRIME_RENDER_OFFLOAD=1 vkcube```

ou :

```__NV_PRIME_RENDER_OFFLOAD=1 __VK_LAYER_NV_optimus=NVIDIA_only vkcube```

ou bien, pour tester que l'Intel intégrée fonctionne tout aussi correctement :

```__NV_PRIME_RENDER_OFFLOAD=1 __VK_LAYER_NV_optimus=non_NVIDIA_only vkcube```


### Test GLX/OpenGL :

```__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia glxgears```

Vous pouvez définir plus finement la commande en ajoutant le nom du vendeur obtenu avec ```xrandr```.

```__NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0 __GLX_VENDOR_LIBRARY_NAME=nvidia glxgears```

# Test direct sur application et variable d'environnement.
Si tous les tests précédent ont retourné les résultat espéré. Vous pouve zdésormais tester vos applications.

Le plus simple serait de tenter d'éditer les profiles dans **nvidia-settings** en ajoutant la variable **__NV_PRIME_RENDER_OFFLOAD=1** pour toutes les applications exécutées par le GPU Nvidia. Ce n'est pas une solution certaine, il n'est pas dit que le système de profiles accepte cette variable puisqu'elle ne fait pas partie officielement de la liste préformatée de **nvidia-settings**.

La seconde est d'éditer le fichier desktop de l'application ou d'en créer une copîe en ajoutant la variable d'environnement en préfixe de l'éxécutable.


# Mise à jour future de nvidia-prime-select.
Mon ordinateur portable ayant déjà 7 ans, je n'ai aucun moyen de tester en direct les nouveaux besoin de Prime. Et je n'ai pas les moyens matériels d'investir dans un nouvel ordinateur portable optimus.
La solution réside soit dans une entraide interactive avec les utilisateurs les plus motivés, soit dans l'investissement dans un ordinateur portable d'occasion de moins de 2 ans avec l'aide la communauté, un budget de 500€ devant suffir.

Si cette solution vous semble convenable vous pouvez faire un don d'1€ à 5€ par utilisateurs motivés avec la référence 'prime' à l'adresse paypal suivante (noneltd[at]gmail[dot]com).

N'ayant pas d'idée particulière pour le choix d'un ordinateur portable optimus qui devra tenir la route sur une longue période, vous pourvez en suggérer un dans le sujet ouvert à cet effet dans l'onglet 'issues'.














