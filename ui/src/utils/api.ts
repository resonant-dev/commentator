import axios from 'axios';
const API_URL = 'http://localhost:4040/api';

export const apiFetch = (config: any) =>
    axios({
        ...config,
        method: config.method || 'get',
        url: `${API_URL}/${config.endpoint}`,
        timeout: config.timeout || 5000,
        ...(config.headers
            ? { headers: config.headers }
            : {
                  headers: {
                      Accept: '*/*',
                      Authorization: '',
                  },
              }),
    })
        .then((res) => res.data)
        .catch((err) => {
            console.error('API request error', err);

            // Otherwise return the error message from axios instance
            // Here we need the error message only but lets keep the error object format { message: err.message}
            const errorInstance = { message: err.message };
            throw errorInstance;
        });
