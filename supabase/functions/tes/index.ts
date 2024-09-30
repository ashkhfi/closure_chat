export async function handler(req: Request): Promise<Response> {
  if (req.method === 'POST') {
    try {
      // Log sederhana yang menunjukkan ada data baru
      console.log('Ada data baru di tabel chats');
      return new Response('Data baru diterima dan dicatat', { status: 200 });
    } catch (error) {
      console.error('Error handling request:', error);
      return new Response('Error processing request', { status: 400 });
    }
  } else {
    return new Response('Method not allowed', { status: 405 });
  }
}
