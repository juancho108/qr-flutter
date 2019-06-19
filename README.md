# QR Reader App

Aplicación en Flutter donde Lee un codigos QR de sitios web o coordenadas de Mapas y abre ambos segun el tipo.

## Breve descripción

El boton central abre la camara del dispositivo y permite escanear un codigo QR.
La app está preparada solamente para detectar QR :

-web ej: https:www.google.com
-maps ej: geo:-34.921690702443165,-57.95414343317873'

Al escanear, la app reconoce automaticamente el tipo y lo abre o en un navegador web o en un mapa (colocando el punto de la coordenada).
Al volver a la pantalla inicial los valores capturados se listarán segun su tipo en cada pestaña: Mapas o Direcciones.

Al deslizar hacia derecha o izquierda sobre el item, lo eliminaremos.

En la parte superior existe un boton de un tacho de basura con una X. Apretando sobre él, eliminamos todos los valores capturados de ambos tipos.
