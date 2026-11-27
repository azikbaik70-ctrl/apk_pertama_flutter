import http from 'k6/http';
import { sleep, check } from 'k6';

export const options = {
  vus: 1,
  duration: '5s',
};

export default function () {
  const url = 'http://127.0.0.1:8080/';
  const res = http.get(url);

  if (res.status !== 200) {
    console.log(`[ERROR] Status Code: ${res.status}`);
    // Bersihkan HTML tag untuk mengambil teks pesan error
    const textOnly = res.body.replace(/<style[\s\S]*?<\/style>/gi, '')
                             .replace(/<script[\s\S]*?<\/script>/gi, '')
                             .replace(/<[^>]+>/g, ' ')
                             .replace(/\s+/g, ' ')
                             .trim();
    console.log(`[ERROR Detail]: ${textOnly.substring(0, 300)}`);
  }

  check(res, {
    'status is 200': (r) => r.status === 200,
  });

  sleep(1);
}