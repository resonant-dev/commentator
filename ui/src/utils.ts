// eslint-disable-next-line @typescript-eslint/no-explicit-any
export const uuidv4 = (a?: any, b?: any): string => {
    for (
        b = a = '';
        a++ < 36;
        b += ~a % 5 | ((a * 3) & 4) ? (a ^ 15 ? 8 ^ (Math.random() * (a ^ 20 ? 16 : 4)) : 4).toString(16) : '-'
    );
    return b;
};
