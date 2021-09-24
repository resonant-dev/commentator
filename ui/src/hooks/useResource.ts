import { useEffect, useReducer } from 'preact/hooks';
import { apiFetch } from '../utils/api';
import useChannel from './useChannel';

type Action = {
    type: ActionTypes;
    payload?: any;
};
type ActionTypes = 'FETCH_START' | 'FETCH_SUCCESS' | 'FETCH_ERROR' | 'CH_NEW_MSG';
type State<T> = {
    loading: boolean;
    data: T[];
    errorMsg: string | null;
    lastFetch: number | null;
    lastError: number | null;
};

const initialState = {
    loading: false,
    data: [],
    lastFetch: null,
    lastError: null,
    errorMsg: null,
};

const reducer = <T>(state: State<T>, { type, payload }: Action) => {
    switch (type) {
        case 'FETCH_START':
            return {
                ...state,
                loading: true,
            };
        case 'CH_NEW_MSG':
        case 'FETCH_SUCCESS':
            return {
                ...state,
                loading: false,
                data: payload,
                errormsg: null,
                lastFetch: Date.now(),
                lastError: null,
            };
        case 'FETCH_ERROR':
            return {
                ...state,
                loading: false,
                errormsg: payload,
                lastError: Date.now(),
            };
        default:
            return state;
    }
};

type Opts = {
    endpoint: string;
    channelRoom: string;
};

const useResource = <T, N = T>({ endpoint, channelRoom }: Opts) => {
    const [state, dispatch] = useReducer<State<T>, Action>(reducer, initialState);
    const { push, subscribe, unsubscribe } = useChannel(channelRoom);

    const fetchData = () => {
        dispatch({ type: 'FETCH_START' });
        return apiFetch({ endpoint })
            .then(({ data }) => {
                dispatch({
                    type: 'FETCH_SUCCESS',
                    payload: data,
                });
            })
            .catch((err) => {
                dispatch({
                    type: 'FETCH_ERROR',
                    payload: err.message,
                });
            });
    };

    const postData = (data: N) => {
        dispatch({ type: 'FETCH_START' });
        return apiFetch({
            endpoint,
            method: 'post',
            data: {
                data: { attributes: data },
            },
        })
            .then(({ data }) => {
                dispatch({
                    type: 'FETCH_SUCCESS',
                    payload: state.data.concat(data),
                });
            })
            .catch((err) => {
                dispatch({
                    type: 'FETCH_ERROR',
                    payload: err.message,
                });
            });
    };

    useEffect(() => {
        subscribe('new_comment', (comment) => {
            dispatch({ type: 'CH_NEW_MSG', payload: state.data.concat(comment) });
        });
        fetchData();
        return () => {
            unsubscribe('new_comment');
        };
    }, []);

    return {
        ...state,
        postData,
        push,
        subscribe,
    };
};

export default useResource;
