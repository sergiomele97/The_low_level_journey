/*
 * kernel.c - Nuestro primer kernel en C
 */

void kmain() {
  char *video_memory = (char *)0xb8000;
  char *message = "Kernel en C ejecutandose correctamente!";
  
  // Color: blanco sobre azul (0x1f)
  // Cada caracter en la pantalla VGA ocupa 2 bytes: [Character][Attribute]
  for (int i = 0; message[i] != '\0'; i++) {
    video_memory[i * 2] = message[i];
    video_memory[i * 2 + 1] = 0x1f; 
  }
}
