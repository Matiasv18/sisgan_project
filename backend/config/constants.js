// application constants

export const USER_ROLES = {
    ADMIN: 'admin',
    GANADERO: 'ganadero',
    VETERINARIO: 'veterinario'
};

export const ANIMAL_STATUS = {
    HEALTHY: 'saludable',
    SICK: 'enfermo',
    RECOVERED: 'recuperado',
    DECEASED: 'fallecido'
};

export const ANIMAL_TYPES = {
    CATTLE: 'ganado',
    SHEEP: 'ovejas',
    GOATS: 'cabras'
};

export const BREEDING_STATUS = {
    PREGNANT: 'preñada',
    IN_LABOR: 'en_parto',
    LACTATING: 'lactando'
};

export const HTTP_STATUS_CODES = {
    OK: 200,
    CREATED: 201,
    BAD_REQUEST: 400,
    UNAUTHORIZED: 401,
    FORBIDDEN: 403,
    NOT_FOUND: 404,
    INTERNAL_SERVER_ERROR: 500
};

export const RESPONSE_MESSAGES = {
    SUCCESS: 'Operación exitosa.',
    NOT_FOUND: 'Recurso no encontrado.',
    BAD_REQUEST: 'Solicitud incorrecta.',
    UNAUTHORIZED: 'No autorizado.',
    FORBIDDEN: 'Acceso prohibido.',
    INTERNAL_ERROR: 'Error interno del servidor.'
};